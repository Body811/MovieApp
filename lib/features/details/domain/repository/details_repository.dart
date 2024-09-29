abstract interface class DetailsRepository<T> {
  Future<T> get(int id);
}