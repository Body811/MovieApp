abstract class AuthRepository<T, Params> {
  Future<T> invoke({required Params params});
}