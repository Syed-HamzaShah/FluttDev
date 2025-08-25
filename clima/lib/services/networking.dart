import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  Networking({this.url});

  final String? url;

  Future<dynamic> getData() async {
    final response = await http.get(Uri.parse(url!));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('Failed to fetch data: ${response.statusCode}');
    }
  }
}
