

from datetime import datetime
from bson import objectid


class Category:
    __slots__ = ('category_id', 'title', 'create_date', 'products')

    def __init__(self,
                 category_id: objectid,
                 title: str,
                 craete_date: datetime,
                 **kwargs
                 ) -> None:

        self.category_id = category_id
        self.title = title
        self.create_date = craete_date
        self.products = kwargs.get('products')


class Product:
    __slots__ = ('products_id', 'title', 'price',
                 'create_date', 'is_favorite', 'description',
                 'images', 'colors', 'sizes', 'comments')

    def __init__(self,
                 product_id: objectid,
                 title: str,
                 price: float,
                 create_date: datetime,
                 **kwargs
                 ) -> None:

        self.product_id = product_id
        self.title = title
        self.price = price
        self.create_date = create_date

        self.is_favorite = kwargs.get('is_favorites')
        self.description = kwargs.get('description')
        self.images = kwargs.get('images')
        self.colors = kwargs.get('colors')
        self.sizes = kwargs.get('sizes')
        self.comments = kwargs.get('comments')


class User:
    __slots__ = ('user_id', 'username', 'name',
                 'family', 'email', 'create_date',
                 'phone_number')

    def __init__(self,
                 user_id: objectid,
                 username: str,
                 name: str,
                 family: str,
                 email: str,
                 create_date: datetime,
                 **kwargs) -> None:

        self.username = username
        self.name = name
        self.family = family
        self.email = email
        self.create_date = create_date
        self.phone_number = kwargs.get('phone_number')


class Blog:
    __slots__ = ('blog_id', 'title', 'description',
                 'create_date', 'comments')

    def __init__(self,
                 blog_id: objectid,
                 title: str,
                 description: str,
                 create_date: datetime,
                 **kwargs,
                 ) -> None:

        self.blog_id = blog_id
        self.title = title
        self.description = description
        self.create_date = create_date
        self.comments = kwargs.get('comments')


class Comment:

    __slots__ = ('comment_id', 'message', 'create_date',
                 'user', 'reference')

    def __init__(self,
                 comment_id: objectid,
                 message: str,
                 create_date: datetime,
                 user: User,
                 reference: object,
                 ** kwargs,
                 ) -> None:

        self.comment_id = comment_id
        self.message = message
        self.create_date = create_date
        self.user = user
        self.reference = reference
