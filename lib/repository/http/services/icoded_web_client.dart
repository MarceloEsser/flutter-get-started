import 'package:workshop/model/icoded.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../web_client.dart';

class IcodedWebClient {
  Future<List<Icoded>> getAllIcoders() async {
    final Response response = await client.get(Uri.parse("$baseUrl/icoded"));
    return toIcodedList(response);
  }

  List<Icoded> toIcodedList(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) {
      return Icoded.fromJson(json);
    }).toList();
  }
}