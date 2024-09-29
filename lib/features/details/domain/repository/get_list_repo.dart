abstract class GetItemsListRepo<T> {
  Future<List<T>>getItems({num? id, Map<String, dynamic>? params});
}