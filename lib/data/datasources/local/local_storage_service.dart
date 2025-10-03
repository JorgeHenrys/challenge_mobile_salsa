import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late Box _box;
  late SharedPreferences _prefs;

  Future<void> init() async {
    _box = await Hive.openBox('app_data');
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> put(String key, dynamic value) async {
    await _box.put(key, value);
  }

  dynamic get(String key) {
    return _box.get(key);
  }

  Future<void> addToList(String key, String value) async {
    final List<String> list = List<String>.from(
      _box.get(key, defaultValue: []),
    );
    if (!list.contains(value)) {
      list.add(value);
      await _box.put(key, list);
    }
  }

  Future<void> removeFromList(String key, String value) async {
    final List<String> list = List<String>.from(
      _box.get(key, defaultValue: []),
    );
    list.remove(value);
    await _box.put(key, list);
  }

  List<String> getList(String key) {
    return List<String>.from(_box.get(key, defaultValue: []));
  }

  bool listContains(String key, String value) {
    final List<String> list = List<String>.from(
      _box.get(key, defaultValue: []),
    );
    return list.contains(value);
  }
}
