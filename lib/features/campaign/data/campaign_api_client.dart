import 'package:dio/dio.dart';
import 'package:f_localbrand/features/campaign/dto/campaign_dto.dart';

class CampaignApiClient {
  CampaignApiClient(this.dio);

  final Dio dio;

  Future<List<CampaignDto>> fetchCampaigns() async {
    try {
      final campaigns = await dio.get('/campaigns/filter');
      if (campaigns.statusCode == 200) {
        return (campaigns.data['result']['campaigns'] as List)
            .map((e) => CampaignDto.fromJson(e))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
