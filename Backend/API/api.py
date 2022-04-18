import falcon
from Resources.resources import collect_resources

app = application = falcon.App()


def add_all_routes(app: falcon.App) -> None:
    """

    """

    for index, resource in enumerate(collect_resources()):

        urls: tuple = resource['path']['uri']
        suffix: tuple = resource['path']['suffix']

        for index, url in enumerate(urls):
            try:
                app.add_route(uri_template=url,
                              resource=resource['resource'],
                              suffix=suffix[index]
                              )
            except IndexError as e:
                # Did not added suffix
                app.add_route(uri_template=url, resource=resource['resource'])


add_all_routes(app)
