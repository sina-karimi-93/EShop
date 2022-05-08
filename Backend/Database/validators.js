
// ================================================ Products =====================================================

/*

{
    "_id":ObjectId(""),
    "title": String,
    "price": double,
    "description": String,
    "create_date": Datetime,
    "categories": [String],
    "sizes": [String],
    "colors":[String],
    "images":[Binary]
    "comments":[
        {
            "id": ObjectId(),
            "message": String,
            "owner": ObjectId(user),
            "create_date": Datetime,
        }
    ]
}

*/


products_validator = {
    collMod: "products",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["title", "price", "description", "create_date", "categories", "images"],
            properties: {
                title: {
                    bsonType: "string",
                    description: "This is the title of each product and necessarry"
                },
                price: {
                    bsonType: "double",
                    description: "This is the price of each product and necessarry"
                },
                description: {
                    bsonType: "string",
                    description: "This is the description of each product and necessarry"
                },
                create_date: {
                    bsonType: "date",
                    description: "This is the creation date of each product and necessarry"
                },
                categories: {
                    bsonType: "array",
                    description: "This is the arrays of categories of each product and necessarry",
                    items: {
                        bsonType: "string",
                        description: "Each category represent a string."
                    }
                },
                images: {
                    bsonType: "object",
                    description: "This is the arrays of images for each product and necessarry",
                    items: {
                        bsonType: "string",
                        description: "Each image represent a string."
                    }
                }
            }
        }
    },
    validationAction: "error"
}
// ================================================ Cards =====================================================

/*

{
    "_id": ObjectId(),
    "owner": ObjectId(user),
    "items": [ 
        {   "item": ObjectId(product),
            "count": Integer,
            "total_item_price": double      
        }
    ],
    "total_price": double,
}

*/

var card_validator = {
    collMod: "cards",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["owner", "items", "total_price"],
            properties: {
                "owner": {
                    bsonType: "ObjectId",
                    description: "This is reference to the owner of this card."
                },
                "items": {
                    bsonType: "Array",
                    description: "This is an array of all products which user added.",
                    items: {
                        bsonType: "object",
                        required: ["item", "count", "total_item_price"],
                        properties: {
                            "item": {
                                bsonType: "ObjectId",
                                description: "Referes to the product id"
                            },
                            "count": {
                                bsonType: "Integer",
                                description: "Number of that product which added."
                            },
                            "total_item_price": {
                                bsonType: "double",
                                description: "Total price of this added product."
                            }
                        }
                    }
                },
                "total_price": {
                    bsonType: "double",
                    description: "Total price of all items added to the card."
                }
            }
        }
    },
    validationAction: "error"
}

