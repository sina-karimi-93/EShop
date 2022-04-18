

from abc import ABCMeta, abstractmethod


class BaseResource(metaclass=ABCMeta):
    """
    This is an interface for resources. Each resource for
    api have to implement this class.In this way they added
    to API through add_routes...

    methods:
        get_pathes() -> All subclasses have to override this method
        because it is necessary for adding them to routes.
    """

    @staticmethod
    @abstractmethod
    def get_pathes() -> dict:
        """
        The desired implementing for this method is like below:

        def get_pathes(self) -> dict:

            pathes = {
                "uri" : ("/some-uri-template", "/another-uri/{dynamic-uri}"),
                "suffix : ("list", "detail")
            }

            return pathes
        """
        pass
