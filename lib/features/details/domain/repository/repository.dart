abstract class Repository<T> {
  Future<T> fetch({num? id, Map<String, dynamic>? params});
}