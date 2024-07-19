import 'package:f_localbrand/features/collection/data/collection_api_client.dart';
import 'package:f_localbrand/features/collection/dto/collection_dto.dart';

class CollectionRepository {
  final CollectionApiClient collectionApiClient;
  CollectionRepository({required this.collectionApiClient});
  Future<List<CollectionDto>> getCollectionList() async {
    try {
      final response = await collectionApiClient.getCollectionList();
      return response;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
