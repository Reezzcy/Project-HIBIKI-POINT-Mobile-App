import 'package:project_hibiki_point_mobile_app/data/response/campaign_response.dart'; // Impor CampaignModel yang sudah ada

/// Kelas ini mem-parsing 'data' dari API yang berisi LIST dari objek campaign.
class CampaignListResponse {
  final List<CampaignModel> campaigns;

  CampaignListResponse({required this.campaigns});

  /// Factory constructor yang akan kita panggil dari Repository.
  /// Ia menerima List<dynamic> yang merupakan isi dari 'data'.
  factory CampaignListResponse.fromData(List<dynamic> data) {
    return CampaignListResponse(
      // Ubah setiap item di list JSON menjadi objek CampaignModel
      campaigns: List<CampaignModel>.from(
        data.map((item) => CampaignModel.fromJson(item)),
      ),
    );
  }
}
