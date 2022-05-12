"""
The core of the API is here. For this application we use
Falcon framework for API.
"""

import falcon
from .Resources.resources import *
app = application = falcon.App()

# instantiate resources

products = Products()
carts = Carts()
users = Users()
blogs = Blogs()
admin = Admin()

# Add routes
#  ================================================ Products =====================================================

app.add_route('/products', products)
app.add_route('/products/{product_id}', products, suffix='detail')
app.add_route('/products/comment/{product_id}', products, suffix='comment')
app.add_route(
    '/products/comment/{product_id}/{comment_id}', products, suffix='comment')
app.add_route('/products/categories', products, suffix='categories')
app.add_route('/products/categories/{category_name}',
              products, suffix='category_products')

#  ================================================ Cards =====================================================
app.add_route('/carts/{user_id}', carts, suffix="detail")

#  ================================================ Blogs =====================================================
app.add_route('/blogs', blogs)
app.add_route('/blogs/{blog_id}', blogs, suffix='detail')

#  ================================================ Users =====================================================

app.add_route('/users/login', users, suffix='login')
app.add_route('/users/signup', users, suffix='signup')
app.add_route('/users/edit', users, suffix='edit')

#  ================================================ Admin =====================================================
app.add_route('/admin', admin)
