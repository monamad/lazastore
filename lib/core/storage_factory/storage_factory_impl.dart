import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazastore/core/storage_factory/storage_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageFactory implements StorageInterface {
  final SharedPreferences prefs;
  final FlutterSecureStorage secureStorage;

  StorageFactory({required this.secureStorage, required this.prefs});

  // ==================== Shared Preferences ====================
  @override
  Future<bool> saveString(String key, String value) async {
    ();
    return await prefs.setString(key, value);
  }

  @override
  String? getString(String key) {
    ();
    return prefs.getString(key);
  }

  @override
  Future<bool> saveStringList(String key, List<String> list) async {
    ();
    return await prefs.setStringList(key, list);
  }

  @override
  List<String>? getStringList(String key) {
    ();
    return prefs.getStringList(key);
  }

  @override
  Future<bool> saveObject(String key, Map<String, dynamic> object) async {
    ();
    return await prefs.setString(key, jsonEncode(object));
  }

  @override
  Map<String, dynamic>? getObject(String key) {
    ();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  @override
  Future<bool> remove(String key) async {
    ();
    return await prefs.remove(key);
  }

  @override
  Future<void> clearAll() async {
    ();
    await prefs.clear();
  }

  // ==================== Secure Storage ====================
  @override
  Future<void> saveSecure(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getSecure(String key) async {
    return await secureStorage.read(key: key);
  }

  @override
  Future<void> removeSecure(String key) async {
    await secureStorage.delete(key: key);
  }

  @override
  Future<void> clearSecure() async {
    await secureStorage.deleteAll();
  }
}
