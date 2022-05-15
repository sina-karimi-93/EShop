# EShop
This project is about to developing an online shop.

I have tried to use MongoDB and Falcon (Python API Framework) for backend.
and for front-end, I am using Flutter for mobile and desktop apps.

# Database
Database has several collections, namely products, carts, users and orders.

users:
    {
        _id : ObjectId,
        username : String,\n
        email : String,
        password : String,
        create_date : Date
    }

carts:
    {
        _id : ObjectId,
        owner : ObjectId,
        items: [
            {
                item : ObjectId,
                count : Int,
                price : double
                total_item_price : double,
                color : String,
                size : String
            }
        ],
        total_price : double,
        total_count : Int        
    }

products:
    {
        _id : ObjectId,
        title : String,
        price : double,
        description : String,
        create_date : Date,
        sizes : [String],
        colors : [String],
        categories : [String],
        comments : [
            {
                id : ObjectId,
                ownner : ObjectId,
                username : String,
                comment : String,
                create_date : Date
            }
        ],
        images : [Binary]
    }