import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {
  dynamic fetchJSONFrom({required String url}) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  fetchImageURLFrom({required String url}) async {}
}
