import 'package:shared_preferences/shared_preferences.dart';

class LocalSettings {
  late SharedPreferences preferences;

  Future<void> getInstance() async {
    preferences = await SharedPreferences.getInstance();
  }
}
