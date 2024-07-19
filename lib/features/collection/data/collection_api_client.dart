import 'package:dio/dio.dart';
import 'package:f_localbrand/features/collection/dto/collection_dto.dart';

class CollectionApiClient {
  final Dio dio;

  CollectionApiClient(this.dio);

  Future<List<CollectionDto>> getCollectionList() async {
    try {
      final response = await dio.get('/collections/filter');
      return (response.data['result']['collections'] as List)
          .map((e) => CollectionDto.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }
    return [];
  }
}
