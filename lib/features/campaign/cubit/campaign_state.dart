part of 'campaign_cubit.dart';

sealed class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

final class CampaignInitial extends CampaignState {}

class GetCampaignsLoading extends CampaignState {}

class GetCampaignsSuccess extends CampaignState {
  final List<CampaignDto> campaigns;

  GetCampaignsSuccess({required this.campaigns});

  @override
  List<Object> get props => [campaigns];
}

class GetCampaignsFailure extends CampaignState {}
