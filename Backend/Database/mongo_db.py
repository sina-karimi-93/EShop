"""
This module stands for handilng datebase operations such as
connect and disconnect and CRUD operations. The desired database
is MongoDB.
"""


from datetime import datetime
from pymongo import MongoClient


class Database:

    """
    This class is stands for CRUD operation in MongoDB databases.

    methods:
        _get_collection()
        insert()
        get()
        update()

    Context Manager:
        __enter__()
        __exit__()
    """

    def __init__(self,
                 host: str,
                 port: int,
                 db_name: str,
                 collection_name: str,
                 **kwargs
                 ):
        """
        Here we connect to the MongoDB via MongoClient and get the desired database.

        params:
            host -> Address of the mongodb
            port -> Port of the mongodb
            db_name -> The name of the desired database
        """
        self.client = MongoClient(host=host, port=port)
        self.db = self.client[db_name]
        self.collection = self.db[collection_name]

    def __enter__(self) -> None:
        """
        Implementing this magic method to convert this class to
        context manager.
        We return self to use instantiating in the with statement like:
        with class() as c
        """
        return self

    def __exit__(self, exc_type, exc_value, exc_traceback) -> None:
        """ 
        Implementing this magic method to convert this class to
        context manager.
        After this class in a with statement wants to be closed,
        here the connection with the database will be terminated.
        """
        self.client.close()

    def insert_record(self, document: dict or list, insert_one: bool = True) -> None:
        """
        This method is stands for create operation in CRUD.
        First it gets the collection name and based on the insert type (one or many), 
        it insert the data to the collection.

        params:
            collection_name:str
            document:dict or list(dict for insert_one and list for insert_many)
            insert_one:bool

        return dict or tuple
        """
        if insert_one:
            return self.collection.insert_one(document=document)

        return self.collection.insert_many(document)

    def get_record(self, query: dict, find_one: bool = True, **kwargs) -> dict or tuple:
        """
        This method is stands for read operation in CRUD.
        First it gets the collection name and based on the finding type(one or many), 
        it collect the data.

        params:
            collection_name:str
            query:dict
            find_one:bool

        return:
            dict or tuple
        """
        if find_one:
            return self.collection.find_one(filter=query)

        return self.collection.find(query)

    def update_record(self, criteria: dict, document: dict, update_one: bool = True) -> None:
        """
        This method is stands for update operation in CRUD.
        First it gets the collection name and based on the updating type(one or many), 
        it collect the data.

        params:
            collection_name:str
            query:dict
            find_one:bool

        return:
            dict or tuple
        """

        if update_one:
            return self.collection.update_one(filter=criteria, update=document)

        return self.collection.update_many(filter=criteria, update=document)


with Database('localhost', 27017, db_name='eshop', collection_name='products') as database:
    database: Database
    criteria = {"title": "Kafsh"}
    document = {"$set": {"quantity": 5}}

    database.insert('categories', {"title": 'women',
                    'create_date': datetime.now()})
