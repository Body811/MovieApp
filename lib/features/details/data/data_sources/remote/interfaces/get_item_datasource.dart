import 'package:movie_app/features/details/data/data_sources/remote/interfaces/remote_datasource.dart';

abstract class GetItemDatasource<T> extends RemoteDatasource {
  Future<T> getItem({required num id, Map<String, dynamic>? params});
}
