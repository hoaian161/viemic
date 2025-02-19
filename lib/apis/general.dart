import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/internal.dart';

Future<Map<String, dynamic>> server(String method, String body) async {
    print("---- SERVER CALL: ${method} ==== ${body}");
    final response = await http.post(
        Uri.parse("https://ean.vn/project/viemic/?method=" + method),
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "UserID": Internal().get("user") != null ? Internal().get("user")["id"] : "",
            "UserGID": Internal().get("user") != null ? Internal().get("user")["gid"] : "",
        },
        body: body
    );

    if (response.statusCode == 200) {
        print("---- SERVER RESPONSE: ${response.body}");
        return json.decode(response.body);
    } else {
        throw Exception("Failed to call server: ${response.statusCode}");
    }
}