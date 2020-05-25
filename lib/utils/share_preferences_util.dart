import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesUtil{
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


 static Future<bool> create(String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove("jsonConfiguration").catchError((onError) => print("arquivo não existe"));
     return prefs.setString('jsonConfiguration', value);
  }

  static void remove() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove("jsonConfiguration").catchError((onError) => print("arquivo não existe"));
  }

   static Future<String> load() async {
    final SharedPreferences prefs = await _prefs;
    final String data = (prefs.getString('jsonConfiguration') ?? "");
        return data;
  }

}