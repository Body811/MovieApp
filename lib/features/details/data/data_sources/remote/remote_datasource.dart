import 'package:movie_app/features/details/data/data_sources/datasource.dart';

abstract interface class RemoteDatasource<T> implements Datasource {
  Future<T> getItem({required int id, Map<String, dynamic>? params});
}
