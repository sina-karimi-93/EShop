

from unicodedata import name


class Product:
    def __init__(self, product_id, title: str, price: float, **kwargs) -> None:
        self.product_id = product_id
        self.title = title
        self.price = price
        self.is_favorite = kwargs.get('is_favorites')
        self.colors = kwargs.get('colors')
        self.sizes = kwargs.get('sizes')


class User:
    def __init__(self, username: str, name: str, family: str, email: str, **kwargs) -> None:
        self.username = username
        self.name = name
        self.family = family
        self.email = email
        self.phone_number = kwargs.get('phone_number')
