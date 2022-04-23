"""
The core of the API is here. For this application we use
Falcon framework for API.
"""

import falcon
from .Resources.resources import *

app = application = falcon.App()

# instantiate resources

products = Products()
users = Users()
blogs = Blogs()
admin = Admin()

# Add routes

app.add_route('/products', products)
app.add_route('/products/{product_id}', products, suffix='detail')
app.add_route('/products/comment/{product_id}', products, suffix='comment')
app.add_route(
    '/products/comment/{product_id}/{comment_id}', products, suffix='comment')
app.add_route('/products/categories', products, suffix='categories')
app.add_route('/products/categories/{category_name}',
              products, suffix='category_products')

app.add_route('/blogs', blogs)
app.add_route('/blogs/{blog_id}', blogs, suffix='detail')

app.add_route('/users', users)
app.add_route('/users/{user_id}', users, suffix='detail')


app.add_route('/admin', admin)
