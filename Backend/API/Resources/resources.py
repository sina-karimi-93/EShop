"""
This module is stands for defining resources (each route).
Each resource class have to inherit from BaseResource interface.
"""

import falcon
from datetime import datetime
from bson.objectid import ObjectId
from Database.mongo_db import Database
from ..Tools.tools import APITools


class Products:

    def on_get(self, request, response) -> None:
        """
        This function is for a get request and return all products
        from database.
        """
        with Database('localhost', 27017, 'eshop', 'products') as db:

            products = tuple(db.get_record(query=None, find_one=False))

        APITools.check_prepare_send(response, products)

    def on_get_detail(self, request, response, product_id: str) -> None:
        """
        This function is for a get request and return a single product
        from database.

        params:
            product_id
        """

        with Database('localhost', 27017, 'eshop', 'products') as db:
            db: Database
            try:
                product = db.get_record(query={"_id": ObjectId(product_id)}, find_one=True)

                APITools.check_prepare_send(response, product)

            except Exception as e:
                response.media = falcon.HTTP_404
                print(f"Products/on_get_detail -> {e}")

    def on_post(self, request, response) -> None:
        """
        This function is for a post request and return a single product(s)
        ids after inserting into database.
        """

        data = APITools.prepare_posted_data(request)

        with Database('localhost', 27017, 'eshop', 'products') as db:
            db: Database

            product_ids = db.insert_record(document=data)

        reshaped_ids = APITools.reshape_post_ids(product_ids)

        APITools.prepare_send_data(response, reshaped_ids)

    def on_put_detail(self, request, response, product_id) -> None:
        """
        This function is for a put request. It is responsible for
        adding comments on each product.

        desired data is like below:
            {
                "message": "some text message",
                "owner:: 'user-id'
            }
        """

        data = APITools.prepare_post_data(request)
        prepared_data = {
            "id": ObjectId(),
            "message": data["message"],
            "owner": ObjectId(data["owner"]),
            "create_date": datetime.now()
        }

        with Database('localhost', 27017, 'eshop', 'products') as db:

            db.update_record(criteria={"_id": ObjectId(product_id)},
                             document={"$push": {"comments": prepared_data}},
                             )

        response.media = {"status": falcon.HTTP_200}
        response.status = falcon.HTTP_200


class Blogs:

    def on_get(self, request, response) -> None:
        """"""

    def on_get_detail(self, request, response, blog_id) -> None:
        """"""

    def on_put(self, request, response) -> None:
        """"""


class Users:

    def on_get(self, request, response) -> None:
        """"""

    def on_get_detail(self, request, response, user_id) -> None:
        """"""

    def on_post(self, request, response) -> None:
        """"""
