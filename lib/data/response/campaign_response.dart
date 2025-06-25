import 'dart:convert';

// Model untuk objek 'data' di dalam respons campaign
// Ini bisa juga diletakkan di /data/models/campaign_model.dart jika Anda ingin memisahkannya
class CampaignModel {
  final int campaignId;
  final int userId;
  final String title;
  final String description;
  final String budget;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime updatedAt;
  final DateTime createdAt;

  CampaignModel({
    required this.campaignId,
    required this.userId,
    required this.title,
    required this.description,
    required this.budget,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.updatedAt,
    required this.createdAt,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      campaignId: json["campaign_id"],
      userId: json["user_id"],
      title: json["title"],
      description: json["description"],
      budget: json["budget"],
      status: json["status"],
      startDate: DateTime.parse(json["start_date"]),
      endDate: DateTime.parse(json["end_date"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}

// Kelas ini secara spesifik mem-parsing 'data' dari ResponseModel
// menjadi sebuah CampaignModel.
class CampaignResponse {
  final CampaignModel campaign;

  CampaignResponse({required this.campaign});

  // Factory constructor yang akan kita panggil dari ApiService
  // Ia menerima Map<String, dynamic> yang merupakan isi dari 'data'
  factory CampaignResponse.fromData(Map<String, dynamic> data) {
    return CampaignResponse(
      campaign: CampaignModel.fromJson(data),
    );
  }
}
