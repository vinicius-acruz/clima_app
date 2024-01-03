import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.urlString);

  final String urlString;

  Future getData() async {
    Uri urlUri = Uri.parse(urlString);

    http.Response response = await http.get(urlUri);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
