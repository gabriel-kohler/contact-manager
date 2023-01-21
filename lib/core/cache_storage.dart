abstract class CacheStorage {
  Future<void> save({required String key, required dynamic value});
  Future<dynamic> fetch({required String key});
  Future<void> delete({required String key});
}