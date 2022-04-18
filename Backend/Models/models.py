

from datetime import datetime


class Product:

    def __init__(self,
                 product_id,
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
        self.colors = kwargs.get('colors')
        self.sizes = kwargs.get('sizes')
        self.comments = kwargs.get('comments')


class User:

    def __init__(self,
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

    def __init__(self,
                 title: str,
                 description: str,
                 create_date: datetime,
                 **kwargs,
                 ) -> None:

        self.title = title
        self.description = description
        self.create_date = create_date
        self.comments = kwargs.get('comments')


class Comment:

    def __init__(self,
                 comment: str,
                 create_date: datetime,
                 user: User,
                 **kwargs,
                 ) -> None:

        self.comment = comment
        self.create_date = create_date
        self.user = user
