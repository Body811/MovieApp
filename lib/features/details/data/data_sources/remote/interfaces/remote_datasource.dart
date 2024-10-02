abstract class RemoteDatasource<T>{
  Future<T> fetch({num? id, Map<String, dynamic>? params});
}
