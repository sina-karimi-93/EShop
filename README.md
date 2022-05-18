# EShop
This project is about to developing an online shop.

I have tried to use MongoDB and Falcon (Python API Framework) for backend.
and for front-end, I am using Flutter for mobile and desktop apps.

<img src="https://user-images.githubusercontent.com/58491712/168982911-72423d0f-5574-4074-9be1-3d2442a6d95f.jpg" width="50%" height="50%">

# Design
<h3>Sign Up</h3>
<p>This is the first page of the app. In this page user can register.
For registration, user have to insert his username, email, password and re-enter password.
If registration is successfull, user will redirect to the login page.
In backend, after a user register, we make a new cart based on his id for his/her shopping.
</p>

![1652857999227](https://user-images.githubusercontent.com/58491712/168981382-01642c18-c11a-4156-94d8-cff0581a6c4a.jpg)

<hr/>

<h3>Login</h3>
<p>In this page user can login. For login user have to enter his/her username and password.
After authentication, user's credential will save into device to preventing all the time authentication until he/she logout.
</p>

![1652857999223](https://user-images.githubusercontent.com/58491712/168982987-ff7c1d72-c45e-439d-aedb-128c232c76fc.jpg)

<hr/>

<h3>Home</h3>
<p>This page contains the main pages of this app, namely Shop, Blogs and Artificial Intelligence. Although Blogs and Artificial Intelligence pages are not developped yet.</p>

![1652857999218](https://user-images.githubusercontent.com/58491712/168982964-814a9394-70f0-4af8-a629-c163e0137690.jpg)

<hr/>

<h3>Shop</h3>
<p>This page includes the categories and the product. User can navigate to each category screen ba clickin on them and can see detail of each product by clicking on them.
</p>

![1652857999213](https://user-images.githubusercontent.com/58491712/168982946-1286ab24-95c8-4669-a7af-06c2a1abd539.jpg)

<hr/>

<h3>Product Detail</h3>
<p>
This page contains the detail of a product. It shows the pictures of the product, title, price, description, sizes, colors and comments. Also user can add this product to his/her cart by clicking on the rounded button on bottom of the screen or by clicking on the shop icon on the top-right of the screen.
At the top-right of the screen we can see an icon with a number which shows the number of items in the user's cart.
</p>

![1652857999204](https://user-images.githubusercontent.com/58491712/168982902-9a4b6ddb-4b32-4bea-957a-a7e974824f54.jpg)

<hr/>

<h3>Comments</h3>
<p>
At the bottom of the Product Detail screen we have the comments. Each user can add a comment to the specific product and it will shows here. Also users can remove their comments.
</p>

![1652857999199](https://user-images.githubusercontent.com/58491712/168982886-7a329e6d-d4e6-452c-94e7-f9551bd34e76.jpg)

<hr/>

<h3>Add new comment</h3>
<p>
By clicking on the add new comment in Product Detail page, users can add new comment for that product. It will show a modal dialog to type and submit a comment.
</p>

![1652857999194](https://user-images.githubusercontent.com/58491712/168982875-41b22de1-120e-41b5-87ca-7572055e3dcf.jpg)

<hr/>

<h3>Carts</h3>
<p>
This page shows the user cart and its items . User can increase or deacrease the number of the items, or he/she can remove the items from his/her cart.
</p>

![1652857999188](https://user-images.githubusercontent.com/58491712/168982850-08334272-c78e-4b21-9753-2f00856f1bd9.jpg)







<h3>App Menu</h3>
<p>This is app menu. At the top, we can see a welcome message for the user. Below that there several items which user can navigate through these pages.
</P>

![1652857999209](https://user-images.githubusercontent.com/58491712/168982911-72423d0f-5574-4074-9be1-3d2442a6d95f.jpg)

<hr/>


# Database
Database has several collections, namely products, carts, users and orders.

