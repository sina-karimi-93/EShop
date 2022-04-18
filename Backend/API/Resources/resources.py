"""
This module is stands for defining resources (each route).
Each resource class have to inherit from BaseResource interface.
"""


from Backend.Database.mongo_db import Database


class Products:

    def on_get_list(self, request, response) -> None:
        """"""
        with Database('localhost', 27017, 'eshop', 'products') as db:
            db: Database
            products = db.get_record(query={}, find_one=False)

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


class Comments:

    def on_post(self, request, response) -> None:
        """"""


class Categories:

    def on_get(self, request, response) -> None:
        """"""
