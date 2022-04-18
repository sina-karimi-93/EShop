

from abc import ABCMeta, abstractmethod


class BaseResource(metaclass=ABCMeta):

    @staticmethod
    @abstractmethod
    def get_pathes() -> dict:
        pass
