"""
This module is stands for defining resources (each route).
Each resource class have to inherit from BaseResource interface.
"""

import falcon
from pprint import pprint
from Database.mongo_db import Database
from Models.models import *
from bson import json_util


def prepare_get_data(response, data: list or dict) -> None:
    """
    This function stands for preparing and return data as a response.
    First vai json_utils, data will be serialized as a json, then
    through response, it will be returned.

    params:
        response -> falcon response
        data -> list or dict
    """

    serialized_data = json_util.dumps(data)
    response.media = serialized_data
    response.status = falcon.HTTP_200


def prepare_post_data(request) -> dict:
    """
    This function prepare and reshape the data which came from
    through a post http method. First it read the data through
    request.stream.read(), then decode it with utf-8. Finally
    turn it to python dict with json_utils.loads and return it.
    """
    data = request.stream.read()
    data = data.decode("utf-8")
    data = json_util.loads(data)
    return data


class Products:

    def on_get(self, request, response) -> None:
        """
        This function is for a get request and return all products
        from database.
        """
        with Database('localhost', 27017, 'eshop', 'products') as db:

            products = tuple(db.get_record(query=None, find_one=False))

        prepare_get_data(response, products)

    def on_get_detail(self, request, response, product_id: str) -> None:
        """
        This function is for a get request and return a single product
        from database.

        params:
            product_id
        """

        with Database('localhost', 27017, 'eshop', 'products') as db:
            db: Database

            product = db.get_record(
                {"_id": ObjectId(product_id)})

        prepare_get_data(response, product)

    def on_post(self, request, response) -> None:
        """"""

        data = prepare_post_data(request)


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
