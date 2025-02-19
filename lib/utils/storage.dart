import 'package:shared_preferences/shared_preferences.dart';

class Storage {
    Future<void> set(String field, String value) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(field, value);
    }

    Future<String> get(String field) async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString(field).toString();
    }
}