"""
This module is stands for defining resources (each route).
Each resource class have to inherit from BaseResource interface.
"""

from Resources.interface import BaseResource


def collect_resources() -> tuple:
    """
    BaseResource is the interface and the parent class of the
    resource classes in this module. With the help of __subclasses__()
    method, we get all its subclasses and their get_pathes() method to get
    their pathes and other features. Finaly, we return them as a tuple of
    dictionaries.

    return:
        tuple(dict('resource', 'path'))
    """

    resources = (
        {'resource': resource(),
         'path': resource.get_pathes()
         }
        for resource in BaseResource.__subclasses__()
    )

    return resources

# ================================= Resources =================================


class Products(BaseResource):

    @staticmethod
    def get_pathes() -> dict:
        pathes = {
            'uri': ('/products', '/products/{product_id}'),
            'suffix': ('list', 'detail'),
        }
        return pathes

    def on_get_list(self, request, response) -> None:
        """"""

    def on_get_detail(self, request, response, product_id) -> None:
        """"""


class Users(BaseResource):

    @staticmethod
    def get_pathes() -> dict:
        """"""
        pathes = {
            'uri': ('/users',),
            'suffix': (),
        }
        return pathes

    def on_get_list(self, request, response) -> None:
        """"""

    def on_get_detail(self, request, response, user_id) -> None:
        """"""

    def on_put(self, request, response) -> None:
        """"""


class Blogs(BaseResource):

    @staticmethod
    def get_pathes():
        """"""
        pathes = {
            'uri': ('/blogs', '/blogs/{blog_id}'),
            'suffix': ('list', 'detail'),
        }
        return pathes

    def on_get_list(self, request, response) -> None:
        """"""

    def on_get_detail(self, request, response, blog_id) -> None:
        """"""

    def on_put(self, request, response) -> None:
        """"""
