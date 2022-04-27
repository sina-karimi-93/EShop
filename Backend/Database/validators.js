products_validator = {
    collMod: "posts",
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
                    bsonType: "string",
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
