"""
This module is stands for defining resources (each route).
Each resource class have to inherit from BaseResource interface.
"""

from pprint import pprint
from urllib import response
import falcon
from datetime import datetime
from bson.objectid import ObjectId
from Database.mongo_db import Database
from ..Tools.tools import APITools
from bson.errors import InvalidId


CONFIG = APITools.get_config(path="./API/Config/api_config.json")
SERVER = CONFIG['server']
PORT = CONFIG['port']
DB_NAME = CONFIG['db_name']


class Products:

    def on_get(self, request, response) -> None:
        """
        This function is for a get request and returns all products
        from database.
        """
        print("Products Request")
        with Database(SERVER, PORT, DB_NAME, 'products') as db:

            products = [data for data in db.get_record(
                query=None, find_one=False)]
        APITools.check_prepare_send(response, products)

    # def on_post(self, request, response) -> None:
    #     """
    #     This function is for a post request and return a single product(s)
    #     ids after inserting into database.
    #     """

    #     data = APITools.prepare_header_data(request)

    #     with Database(SERVER, PORT, DB_NAME, 'products') as db:
    #         db: Database

    #         product_ids = db.insert_record(document=data)

    #     reshaped_ids = APITools.reshape_post_ids(product_ids)

    #     APITools.prepare_send_data(response, reshaped_ids)

    def on_get_detail(self, request, response, product_id: str) -> None:
        """
        This function is for a get request and returns a single product
        from database based on specific product_id.

        params:
            product_id
        """

        with Database(SERVER, PORT, DB_NAME, 'products') as db:
            db: Database
            try:
                product = db.get_record(
                    query={"_id": ObjectId(product_id)}, find_one=True)

                APITools.check_prepare_send(response, product)

            except InvalidId as e:
                response.media = {"error": "Wrong ObjectId"}
                print(f"Products/on_get_detail -> {e}")

    def on_get_categories(self, request, response) -> None:
        """
        This function is responsible for a get request and returns all
        products categories from database.

        For this purpose it uses aggregate framework with three stages.

        products in database be like:
            {
                "_id": ObjectId(...),
                "title: "Product Name",
                .
                .
                .

                "categories" : ["Technology", "Laptop"]
            }

        response:
            { "categories" : ["Technology", "Mobile", "Laptop", ...] }
        """
        with Database(SERVER, PORT, DB_NAME, 'products') as db:
            db: Database

            categories_cursor = db.aggregate([
                {"$unwind": "$categories"},
                {"$group": {"_id": 0, "categories": {"$addToSet": "$categories"}}},
                {"$project": {"_id": 0}}
            ])

        APITools.check_prepare_send(response, next(categories_cursor))

    def on_get_category_products(self, request, response, category_name: str) -> None:
        """
        This method get a category name through url and return all products which
        they have this category in their categories array.
        """
        with Database(SERVER, PORT, DB_NAME, 'products') as db:
            db: Database

            cursor = db.get_record(
                {"categories": {"$all": [category_name]}}, find_one=False)

            products = list(cursor)

        APITools.check_prepare_send(response, products)

    def on_post_comment(self, request, response, product_id) -> None:
        """
        This function is for a put request. It is responsible for
        adding comments on each product.

        desired data is like below:
            {
                "message": "some text message",
                "owner:: 'user-id'
            }
        """
        print("New comment request")
        data = APITools.prepare_header_data(request)

        prepared_data = {
            "id": ObjectId(),
            "comment": data["comment"],
            "owner": ObjectId(data["owner"]),
            "username": data["username"],
            "create_date": datetime.now()
        }

        with Database(SERVER, PORT, DB_NAME, 'products') as db:
            db: Database
            comment_id = db.update_record(criteria={"_id": ObjectId(product_id)},
                                          document={
                                              "$push": {"comments": prepared_data}},
                                          )
        prepared_data = APITools.prepare_data_before_send(prepared_data)
        response.media = {
            "status": "ok",
            "message": falcon.HTTP_200,
            "comment": prepared_data,
        }

    def on_delete_comment(self, request, response, product_id: str, comment_id: str) -> None:
        """
        This function is for a delete request. It is responsible for
        deleting a comment on each product.
        user id is come through header (stream) and we check whether
        the user id is match with comment owner or not. If yes it will
        remove the comment, and if not it will response error.
        """
        print("Comment Delete Request")
        data = APITools.prepare_header_data(request)
        print(data)
        user_id = ObjectId(data["user_id"])
        product_id = ObjectId(product_id)
        comment_id = ObjectId(comment_id)

        with Database(SERVER, PORT, DB_NAME, 'products') as db:
            db: Database
            comment = db.get_record(query={"_id": product_id},
                                    projection={"comments": {
                                        "$elemMatch": {"id": comment_id}}},
                                    find_one=True,
                                    )["comments"][0]

            comment_user_id = comment["owner"]
            if comment_user_id == user_id:
                db.update_record(
                    criteria={"_id": product_id},
                    document={"$pull": {"comments": {"id": comment_id}}}
                )
                response.media = {
                    "status": "ok",
                    "message": "comment successfully deleted"
                }
            else:
                response.media = {
                    "status": "error",
                    "message": "owner and the user id are not match!"
                }

    def on_patch_comment(self, request, response, product_id: str, comment_id: str) -> None:
        """
        This function is for a update request. It is responsible for
        editing a comment on each product.
        user id is come through header (stream) and we check whether
        the user id is match with comment owner or not. If yes it will
        edit the comment, and if not it will response error.
        """

        data = APITools.prepare_header_data(request)
        user_id = ObjectId(data["user_id"])
        updated_message = data["message"]
        product_id = ObjectId(product_id)
        comment_id = ObjectId(comment_id)

        with Database(SERVER, PORT, DB_NAME, 'products') as db:
            db: Database
            comment = db.get_record(query={"_id": product_id},
                                    projection={"comments": {
                                        "$elemMatch": {"id": comment_id}}},
                                    find_one=True,
                                    )["comments"][0]

            comment_user_id = comment["owner"]
            if comment_user_id == user_id:
                db.update_record(criteria={"_id": product_id, "comments.id": comment_id},
                                 document={"$set": {"comments.$.message": updated_message}})
            # todo: add responses


class Carts:

    def on_get_detail(self, request, response, user_id: str) -> None:
        """
        This function get the user card shop from database.
        params:
            user_id:str
        """
        print("Cart Request")
        with Database(SERVER, PORT, DB_NAME, 'carts') as db:
            db: Database

            cart = db.get_record(
                {
                    "owner": ObjectId(user_id)
                }
            )
        userCart = APITools.prepare_data_before_send(data=cart)
        response.media = {
            "status": "ok",
            "message": falcon.HTTP_200,
            "userCart": userCart
        }

    def on_post_add(self, request, response, user_id: str) -> None:
        """
        This method make new cart for user. When a user register,
        he/she needs a cart for his/her shop. Here first we get
        user id through post request, then make a new cart based
        on his/her user_id.
        """
        userData = APITools.prepare_header_data(request)
        new_cart = {
            "owner": ObjectId(userData["user"]),
            "items": [],
            "total_count": 0,
            "total_price": 0,
        }
        with Database(SERVER, PORT, DB_NAME, 'carts') as db:
            db: Database

            new_cart_id = db.insert_record(new_cart)
        response.media = {
            "status": "ok",
            "message": falcon.HTTP_200,
            "cart_id": {"$oid": str(new_cart_id)}
        }

    def on_put_detail(self, request, response, user_id: str) -> None:
        """
        This method updates a single cart which related to a
        autheticated user(in front-end).
        """
        print("Cart Update")
        data = APITools.prepare_header_data(request)
        with Database(SERVER, PORT, DB_NAME, 'carts') as db:
            db: Database
            db.replace_record(
                criteria={'owner': ObjectId(user_id)},
                document=data,
            )
        response.media = {
            "status": "ok",
            "message": falcon.HTTP_200,
        }

    def on_delete_detail(self, request, response, user_id: str) -> None:
        """
        This function is for a delete request. It is responsible for
        deleting a cart.
        """
        with Database(SERVER, PORT, DB_NAME, 'carts') as db:
            db: Database

            db.delete_record({"owner": ObjectId(user_id)}, delete_one=True)


class Blogs:

    def on_get(self, request, response) -> None:
        """
        This function is for a get request and returns all blogs
        from database.
        """

        with Database(SERVER, PORT, DB_NAME, 'blogs') as db:
            db: Database

            blogs = db.get_record(query=None, find_one=False)
            blogs = list(blogs)

        APITools.check_prepare_send(response, blogs)

    def on_get_detail(self, request, response, blog_id: str) -> None:
        """
        This function is for a get request and returns a single blog
        from database based on specific blog_id.

        params:
            blog_id
        """

        with Database(SERVER, PORT, DB_NAME, 'blogs') as db:
            db: Database
            try:
                single_blog = db.get_record(query={"_id": ObjectId(blog_id)})

            except InvalidId as e:
                response.media = {"error": "Wrong ObjectId"}
                print(f"Products/on_get_detail -> {e}")

        APITools.check_prepare_send(response, single_blog)


class Users:

    def on_post_login(self, request, response) -> None:
        """
        This method is responsible for check the user credential.
        1- it gets user credential data from header
        2 - checks whether this user exists or not
        3 - check the password is correct or not
        4 - return the user
        5 - if didn't pass the previous stages, return error
        """
        print("LOGIN REQUEST")
        auth_data = APITools.prepare_header_data(request)
        with Database(SERVER, PORT, DB_NAME, 'users') as db:
            db: Database
            user = db.get_record(
                {"username": auth_data["username"]},
                find_one=True,
            )
        if user:
            print("User Exists")
            is_auth = APITools.check_password(
                password=auth_data["password"],
                encoded_password=user["password"]
            )
            if is_auth:
                print("Authenticated")
                user = APITools.prepare_data_before_send(user)
                print(user)
                response.media = {
                    "status": "ok",
                    "message": falcon.HTTP_200,
                    "user": user}
                return
        response.media = {"status": "error",
                          "message": "Invalid username or password"}

    def on_post_signup(self, request, response) -> None:
        """
        This function get the data from body and add new user.
        """
        print("Signup Request")
        user_data = APITools.prepare_header_data(request)
        user_data["create_data"] = datetime.now()
        user_data["password"] = APITools.encode_password(user_data['password'])

        with Database(SERVER, PORT, DB_NAME, 'users') as db:
            db: Database
            user = db.get_record({"username": user_data["username"]})
            if user is None:
                new_user = db.insert_record(user_data)
                new_cart = {
                    "owner": ObjectId(new_user),
                    "items": [],
                    "total_count": 0,
                    "total_price": 0.0,
                }
                # Make new cart for user
                db.collection = 'carts'
                new_cart_id = db.insert_record(new_cart)
                # reshape idies for response
                new_user = APITools.prepare_data_before_send(new_user)
                new_cart_id = APITools.prepare_data_before_send(new_cart_id)
                response.media = {
                    "status": "ok",
                    "message": falcon.HTTP_200,
                    "user": new_user,
                    "cart_id": new_cart_id,
                }
                return
            response.media = {"status": "error",
                              "message": "This username is currently exists!",
                              }

    def on_patch_edit(self, request, response) -> None:
        """
        This method updates the user info.
        """
        user_data = APITools.prepare_header_data(request)
        username = user_data["username"]
        try:
            updated_fields = user_data["updated_fields"]
        except KeyError as e:
            response.media = {"error": "Invalid Key!"}
            return
        with Database(SERVER, PORT, DB_NAME, 'users') as db:
            db: Database

            db.update_record({"username": username}, {
                "$set": updated_fields})
        response.media = falcon.HTTP_200


class Admin:
    pass
