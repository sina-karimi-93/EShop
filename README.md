# EShop
This project is about to developing an online shop.

I have tried to use MongoDB and Falcon (Python API Framework) for backend.
and for front-end, I am using Flutter for mobile and desktop apps.

# Database
Database has several collections, namely products, carts, users and orders.

<h4>users:</h4>
    {<br />
        _id : ObjectId,<br />
        username : String,<br />
        email : String,<br />
        password : String,<br />
        create_date : Date<br />
    }

<h4>carts:</h4>
    {<br />
        _id : ObjectId,<br />
        owner : ObjectId,<br />
        items: [<br />
            {<br />
                item : ObjectId,<br />
                count : Int,<br />
                price : double,<br />
                total_item_price : double,<br />
                color : String,<br />
                size : String<br />
            }
        ],<br />
        total_price : double,<br />
        total_count : Int     <br />   
    }

<h4>products:</h4>
    {<br />
        _id : ObjectId,<br />
        title : String,<br />
        price : double,<br />
        description : String,<br />
        create_date : Date,<br />
        sizes : [String],<br />
        colors : [String],<br />
        categories : [String],<br />
        comments : [<br />
            {<br />
                id : ObjectId,<br />
                ownner : ObjectId,<br />
                username : String,<br />
                comment : String,<br />
                create_date : Date<br />
            }
        ],<br />
        images : [Binary]
    }