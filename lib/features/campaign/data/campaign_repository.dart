import 'package:f_localbrand/features/campaign/data/campaign_api_client.dart';
import 'package:f_localbrand/features/campaign/dto/campaign_dto.dart';

class CampaignRepository {
  final CampaignApiClient campaignApiClient;

  CampaignRepository({required this.campaignApiClient});

  Future<List<CampaignDto>> getCampaigns() async {
    try {
      List<CampaignDto> result =
          campaignApiClient.fetchCampaigns() as List<CampaignDto>;
      return result;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
