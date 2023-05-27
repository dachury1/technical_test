import 'dart:convert';

import 'package:http/http.dart' as http;

class Repository {
  Future<String> getJoke() async {
    String result = '';
    Map<String, String> headers = {
      "x-api-key": '0y5na6k8d2LbuWF6WZBN7g==gFOz304o7EIa1FfS',
    };
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/jokes'),
      headers: headers,
    );
    final jsonResponse = await jsonDecode(response.body);
    result = jsonResponse.first['joke'];
    return result;
  }
}
