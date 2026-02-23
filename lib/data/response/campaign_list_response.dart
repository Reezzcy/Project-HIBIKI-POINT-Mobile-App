import 'package:hibiki_point/data/response/campaign_response.dart';

class CampaignListResponse {
  final List<CampaignResponse> campaigns;

  CampaignListResponse({required this.campaigns});

  factory CampaignListResponse.fromData(List<dynamic> data) {
    return CampaignListResponse(
      campaigns: List<CampaignResponse>.from(
        data.map((item) => CampaignResponse.getCampaign(item)),
      ),
    );
  }
}
