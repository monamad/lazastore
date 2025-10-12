abstract class StorageInterface {
  Future<bool> saveString(String key, String value);

  String? getString(String key);

  Future<bool> saveStringList(String key, List<String> list);

  List<String>? getStringList(String key);

  Future<bool> saveObject(String key, Map<String, dynamic> object);
  Map<String, dynamic>? getObject(String key);

  Future<bool> remove(String key);

  Future<void> clearAll();

  // ==================== Secure Storage ====================

  Future<void> saveSecure(String key, String value);

  Future<String?> getSecure(String key);

  Future<void> removeSecure(String key);

  Future<void> clearSecure();
}
