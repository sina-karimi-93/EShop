from datetime import datetime
from bson import ObjectId, json_util
dataset = [
    {
        "title": "Leather Shoe",
        "price": 119.99,
        "description": "This shoe is made with real leather.",
        "create_date": datetime.now(),
        "sizes": ["37", "38", "39", "40", "41", "42"],
        "colors": ["Black", "Brown", "Hazel"],
        "categories": ["Men", "Shoe"],
        "images": [],
        "comments": []
    },

    {
        "title": "Funnt Hat",
        "price": 19.99,
        "description": "Funny hat for parties.",
        "create_date": datetime.now(),
        "sizes": [],
        "colors": ["Red", "Blue", "Green", "Pink"],
        "categories": ["Men", "Women""Hat"],
        "images": [],
        "comments": []
    },

    {
        "title": "Awesome Shirt",
        "price": 80.99,
        "description": "Every man deserve to be handsome, This shirt has one of best design in the world!",
        "create_date": datetime.now(),
        "sizes": ["Small", "Medium", "Large"],
        "colors": ["Blue", "White", "Cyan"],
        "categories": ["Men", "Shirt"],
        "images": [],
        "comments": []
    },

    {
        "title": "Sport Panths",
        "price": 42.99,
        "description": "These panth are really awesome for any kind of sports.",
        "create_date": datetime.now(),
        "sizes": ["Small", "Medium", "Large"],
        "colors": ["Black", "White", ],
        "categories": ["Men", "Women", "Panths"],
        "images": [],
        "comments": []
    },
    {
        "title": "Purse",
        "price": 99.99,
        "description": "The first choice of every lady.",
        "create_date": datetime.now(),
        "sizes": [],
        "colors": [
            "Black",
            "Brown",
        ],
        "categories": [
            "Women",
            "Bag"
        ],
        "images": [],
        "comments": []
    },
    {
        "title": "Socks",
        "price": 5.99,
        "description": "Warm socks for cold weather",
        "create_date": datetime.now(),
        "sizes": [],
        "colors": ["Black", "Brown", "Red", "Blue"],
        "categories": ["Women", "Men", "Socks"],
        "images": [],
        "comments": []
    },

    {
        "title": "Scarf",
        "price": 15.99,
        "description": "Warm Scarf for cold weather",
        "create_date": datetime.now(),
        "sizes": [],
        "colors": ["Black", "Brown", "Red", "Blue"],
        "categories": ["Women", "Men", "Socks"],
        "images": [],
        "comments": []
    },

    {
        "title": "Sport Shoe",
        "price": 15.99,
        "description": "Comfortable shoe for any sport.",
        "create_date": datetime.now(),
        "sizes": [
            '36', '37', '38', '39', '40', '41', '42'
        ],
        "colors": ["Black", "Brown", "Green", "Yellow"],
        "categories": ["Women", "Men", "Shoe"],
        "images": [],
        "comments": []
    },

    {
        "title": "T-shirt",
        "price": 39.99,
        "description": "Colorful t-shirt for sunny days.",
        "create_date": datetime.now(),
        "sizes": ["Small", "Medium", "Large"],
        "colors": ["Black", "Brown", "Green", "Yellow"],
        "categories": ["Women", "Men", "T-shirt"],
        "images": [],
        "comments": []
    },

    {
        "title": "Cap",
        "price": 10.99,
        "description": "Colorful and fashionable cap.",
        "create_date": datetime.now(),
        "sizes": ["Small", "Medium", "Large"],
        "colors": ["Black", "Brown", "Green", "Yellow"],
        "categories": ["Women", "Men", "T-shirt"],
        "images": [],
        "comments": [
            {
                "id": ObjectId(),
                "owner": ObjectId(),
                "message": "Nice, I bought it and I'm very satisfied.",
                "create_date": datetime.now()
            }
        ]
    },


]

with open("sample-data.json", "w") as f:
    a = json_util.dumps(dataset)
    f.write(a)
