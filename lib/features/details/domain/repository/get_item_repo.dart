abstract class GetItemRepo<T> {
  Future<T>getItem({required num id, Map<String, dynamic>? params});
}