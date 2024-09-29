import 'package:movie_app/features/details/data/data_sources/remote/interfaces/remote_datasource.dart';

abstract class GetListDatasource<T> extends RemoteDatasource{
  Future<List<T>> getList({num? id, Map<String, dynamic>? params});
}