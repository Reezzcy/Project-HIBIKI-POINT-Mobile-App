
import 'package:project_hibiki_point_mobile_app/data/response/campaign_list_response.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_response.dart';
import 'package:project_hibiki_point_mobile_app/data/response/response_model.dart';

import '../api_service.dart';

class CampaignRepository {
  final ApiService _apiService = ApiService();

  /// Mengambil semua campaign dari API
  Future<CampaignListResponse> getAllCampaigns(String token) async {
    return await _apiService.fetchAllCampaigns(token: token);
  }

  /// Membuat campaign baru
  Future<CampaignResponse> createCampaign(Map<String, dynamic> data, String token) async {
    return await _apiService.createCampaign(data, token: token);
  }

  /// Mengupdate campaign yang sudah ada
  Future<CampaignResponse> updateCampaign(int id, Map<String, dynamic> data, String token) async {
    return await _apiService.updateCampaign(campaignId: id, campaignData: data, token: token);
  }

  /// Menghapus campaign
  Future<ResponseModel> deleteCampaign(int id, String token) async {
    return await _apiService.deleteCampaign(campaignId: id, token: token);
  }
}

// Global instance agar mudah diakses
final campaignRepository = CampaignRepository();
