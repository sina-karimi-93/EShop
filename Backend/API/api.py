"""
The core of the API is here. For this application we use
Falcon framework for API.
"""

import falcon
from Resources.resources import *

app = application = falcon.App()

# instantiate resources

products = Products()
users = Users()
blogs = Blogs()
categories = Categories()
comments = Comments()


# Add routes

app.add_route('/products', products, suffix='list')
app.add_route('/products/{product_id}', products, suffix='detail')

app.add_route('/blogs', blogs, suffix='list')
app.add_route('/blogs/{blog_id}', blogs, suffix='detail')

app.add_route('/categories', categories, suffix='list')
app.add_route('/categories/{category_id}', categories, suffix='detail')

app.add_route('/comments', comments)
