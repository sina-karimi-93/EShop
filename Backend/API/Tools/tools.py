from curses import has_il
from datetime import datetime
import json
import falcon
import bcrypt
from bson import json_util
from pprint import pprint


class APITools:

    @staticmethod
    def get_config(path: str) -> dict:
        """
        This method loads the config from a json file in 
        Config folder

        params:
            path:str
        """

        with open(path, 'r') as f:
            config = f.read()
        return json.loads(config)

    @staticmethod
    def check_prepare_send(response, data: list or dict) -> None:
        """
        This function stands for preparing and return data as a response.
        First via json_utils, data will be serialized as a json, then
        through response, it will be returned.

        params:
            response -> falcon response
            data -> list or dict
        """
        if data:
            reshape_fields = json_util.dumps(data)
            serialized_data = json.loads(reshape_fields)
            response.media = serialized_data
            response.status = falcon.HTTP_201
            return
        response.media = falcon.HTTP_404

    @staticmethod
    def prepare_header_data(request) -> dict or list:
        """
        This function prepare and reshape the data which came from
        through a post http method. First it read the data through
        request.stream.read(), then decode it with utf-8. Finally
        turn it to python dict with json_utils.loads() and return it.
        """
        data = request.stream.read()
        data = data.decode("utf-8")
        data = json_util.loads(data)
        return data

    @staticmethod
    def reshape_post_ids(ids: list or str) -> dict:
        """
        After inserting data into database, MongoDB will return the ids
        of the inserted data. This function reshape them as a meaningful
        dictionary for response.

        raw data -> ObjectId or list of ObjectIds
        """
        if isinstance(ids, list):
            response = {
                "ids": [str(i) for i in ids]
            }
            return response
        return str(ids)

    @staticmethod
    def encode_password(password: str) -> str:
        """
        This function hash passwords and return them as string to 
        store them in database.
        """

        hashed_password = bcrypt.hashpw(password.encode(), bcrypt.gensalt())
        return hashed_password.decode()

    def check_password(password: str, encoded_password: str) -> bool:
        """
        This method check whether a password is match to existing or not.

        args:
            password -> input password from client
            encoded_password -> existing password in database
        """

        is_match = bcrypt.checkpw(password.encode(), encoded_password.encode())
        return is_match



