"""
This module is stands for defining resources (each route).
Each resource class have to inherit from BaseResource interface.
"""

import json
import falcon
from pprint import pprint
from Database.mongo_db import Database
from Models.models import *
from bson import json_util


def reshape_data(data) -> json:
    """"""
    data = [d for d in data]
    data = []


class Products:

    def on_get_list(self, request, response) -> None:
        """"""
        with Database('localhost', 27017, 'eshop', 'products') as db:

            products = db.get_record(query={}, find_one=False)
            products = [product for product in products]

        products_json = json_util.dumps(products)

        response.media = products_json
        response.status = falcon.HTTP_200

    def on_get_detail(self, request, response, product_id) -> None:
        """"""


class Users:

    def on_get_list(self, request, response) -> None:
        """"""

    def on_get_detail(self, request, response, user_id) -> None:
        """"""

    def on_put(self, request, response) -> None:
        """"""


class Blogs:

    def on_get_list(self, request, response) -> None:
        """"""

    def on_get_detail(self, request, response, blog_id) -> None:
        """"""

    def on_put(self, request, response) -> None:
        """"""


class Categories:

    def on_get_list(self, request, response) -> None:
        """"""

    def on_get_detail(self, request, response, category_id) -> None:
        """"""


class Comments:

    def on_post(self, request, response) -> None:
        """"""
