from datetime import datetime
import pymongo
from pymongo import MongoClient


class Database:

    """
    This class is stands for CRUD operation in MongoDB databases.

    methods:
        _get_collection()
        insert()
        get()
        update()

    magic methods:
        __enter__()
        __exit__()
    """

    def __init__(self, host: str, port: int, db_name: str):
        """
        Here we connect to the MongoDB via MongoClient and get the desired database.

        params:
            host -> Address of the mongodb
            port -> Port of the mongodb
            db_name -> The name of the desired database
        """
        self.client = MongoClient(host=host, port=port)
        self.db = self.client[db_name]

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

    def _get_collection(self, collection_name: str) -> pymongo.collection:
        """
        This private method get the collection from the database.
        If the desired collection is not in the database, it will
        raise an AttributeError.
        """

        collections = self.db.list_collection_names()
        collection_count = collections.count(collection_name)
        if collection_count > 0:
            return self.db[collection_name]
        raise AttributeError("The desired collection was not found!")

    def insert(self, collection_name: str, document: dict or list, insert_one: bool = True) -> None:
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
        collection = self._get_collection(collection_name=collection_name)
        if insert_one:
            return collection.insert_one(document=document)

        return tuple(collection.insert_many(document))

    def get(self, collection_name: str, query: dict, find_one: bool = True) -> dict or tuple:
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
        collection = self._get_collection(collection_name=collection_name)

        if find_one:
            return collection.find_one(filter=query)

        return tuple(collection.find(query))

    def update(self, collection_name: str, criteria: dict, document: dict, update_one: bool = True) -> None:
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
        collection = self._get_collection(collection_name=collection_name)

        if update_one:
            return collection.update_one(filter=criteria, update=document)

        return tuple(collection.update_many(filter=criteria, update=document))


with Database(host='localhost', port=27017, db_name='eshop') as database:
    database: Database
    criteria = {"title": "Kafsh"}
    document = {"$set": {"quantity": 5}}

    database.insert('categories', {"title": 'women',
                    'create_date': datetime.now()})
