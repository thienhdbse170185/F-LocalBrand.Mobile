import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/campaign/data/campaign_repository.dart';
import 'package:f_localbrand/features/campaign/dto/campaign_dto.dart';

part 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  CampaignCubit({required this.campaignRepository}) : super(CampaignInitial());
  final CampaignRepository campaignRepository;

  Future<void> fetchCampaigns() async {
    emit(GetCampaignsLoading());
    try {
      final campaigns = await campaignRepository.getCampaigns();
      emit(GetCampaignsSuccess(campaigns: campaigns));
    } catch (e) {
      emit(GetCampaignsFailure());
    }
  }
}
