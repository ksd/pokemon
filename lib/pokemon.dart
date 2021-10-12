import 'package:http/http.dart' as http;
import 'dart:convert';

class Pokemon {
  final String name;
  final String url;
  bool favorite = false;

  Pokemon({required this.name, required this.url});

// named constructor der kaldes med noget JSON vi får et andet sted fra
  factory Pokemon.fromJSON(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      url: json['url'],
    );
  }

  Future<String> fetchImageURL() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData['sprites']['other']['official-artwork']['front_default'];
    } else {
      return "";
    }
  }
}
