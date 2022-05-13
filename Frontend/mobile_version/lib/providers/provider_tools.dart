import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> getDataFromServer(String path) async {
  /*
    This method is responsible for getting data from the server.
    First it get data from server, and via json package, we decode
    it to readble data like List<Map<...>> or Map<...> then return
    it.

    args:
      path -> server url
    */
  try {
    final url = Uri.http('192.168.1.104:8000', path);

    var response = await http.get(url);
    var data = response.body;
    var decodedData = json.decode(data);
    return decodedData;
  } catch (error) {
    rethrow;
  }
}

Future<dynamic> sendDataToServer(String path, Map<String, dynamic> data) async {
  /*
  This method is for send data to the server via a post request
  and return it's response.

  args:
    path -> desired url
    data -> desired data as a Map
  */
  try {
    final url = Uri.http('192.168.1.104:8000', path);
    var response = await http.post(url, body: data);
    var body = response.body;
    var decodedData = json.decode(body);
    return decodedData;
  } catch (error) {
    rethrow;
  }
}
