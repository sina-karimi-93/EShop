"""
This module is stands for defining resources (each route).
Each resource class have to inherit from BaseResource interface.
"""

from pprint import pprint
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
        print("There is a request...")
        with Database(SERVER, PORT, DB_NAME, 'products') as db:

            products = [data for data in db.get_record(
                query=None, find_one=False)]

        APITools.check_prepare_send(response, products)
        print("Request has beeen answered!")

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
        This function is for a get request and returns all products
         categories from database.
        """
        with Database(SERVER, PORT, DB_NAME, 'products') as db:
            db: Database

            categories_cursor = db.aggregate([
                {"$unwind": "$categories"},
                {"$group": {"_id": 0, "categories": {"$addToSet": "$categories"}}},
                {"$project": {"_id": 0}}
            ])

        APITools.check_prepare_send(response, next(categories_cursor))

    def on_get_categories_products(self, request, response, category_name: str) -> None:
        """
        """

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
        data = APITools.prepare_header_data(request)

        prepared_data = {
            "id": ObjectId(),
            "message": data["message"],
            "owner": ObjectId(data["owner"]),
            "create_date": datetime.now()
        }

        with Database(SERVER, PORT, DB_NAME, 'products') as db:

            db.update_record(criteria={"_id": ObjectId(product_id)},
                             document={"$push": {"comments": prepared_data}},
                             )

        response.text = falcon.HTTP_200
        response.status = falcon.HTTP_200

    def on_delete_comment(self, request, response, product_id: str, comment_id: str) -> None:
        """
        This function is for a delete request. It is responsible for
        deleting a comment on each product.
        user id is come through header (stream) and we check whether
        the user id is match with comment owner or not. If yes it will
        remove the comment, and if not it will response error.
        """
        data = APITools.prepare_header_data(request)
        user_id = ObjectId(data["user_id"])
        product_id = ObjectId(product_id)
        comment_id = ObjectId(comment_id)
        with Database(SERVER, PORT, DB_NAME, 'products') as db:
            comment = db.get_record(query={"_id": product_id},
                                    projection={"comments": {
                                        "$elemMatch": {"id": comment_id}}},
                                    find_one=True,
                                    )["comments"][0]

            comment_user_id = comment["owner"]
            if comment_user_id == user_id:
                db.delete_record({"_id": product_id,
                                  "comments": {
                                      "$elemMatch": {
                                          "id": comment_id
                                      }
                                  }})
            # todo: add responses

    def on_put_comment(self, request, response, product_id: str, comment_id: str) -> None:
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
                db.collection.find_one_and_update
                db.update_record(criteria={"_id": product_id, "comments.id": comment_id},
                                 document={"$set": {"comments.$.message": updated_message}})
            # todo: add responses


class Blogs:

    def on_get(self, request, response) -> None:
        """
        This function is for a get request and returns all blogs
        from database.
        """

        with Database(SERVER, PORT, DB_NAME, 'blogs') as db:
            db: Database

            blogs = db.get_record(query=None, find_one=False)

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

    def on_get(self, request, response) -> None:
        """"""

    def on_get_detail(self, request, response, user_id) -> None:
        """"""

    def on_post(self, request, response) -> None:
        """"""


class Admin:
    pass
