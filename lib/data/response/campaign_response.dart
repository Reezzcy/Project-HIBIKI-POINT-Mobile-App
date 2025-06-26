import 'package:project_hibiki_point_mobile_app/data/models/attachment_model.dart';
import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';

class CampaignResponse extends CampaignModel{
  final AttachmentModel attachment;

  CampaignResponse({
    required super.campaignId,
    required super.userId,
    required super.attachmentId,
    required super.title,
    required super.description,
    required super.budget,
    required super.status,
    required super.startDate,
    required super.endDate,
    required this.attachment
  });

  factory CampaignResponse.getCampaign(Map<String, dynamic> object) {
    return CampaignResponse(
      campaignId: object["campaign_id"],
      userId: object["user_id"],
      attachmentId: 1,
      title: object["title"],
      description: object["description"],
      budget: object["budget"],
      status: object["status"],
      startDate: DateTime.parse(object["start_date"]),
      endDate: DateTime.parse(object["end_date"]),
      attachment: AttachmentModel(attachmentId: 1, file: file, uploadedBy: 1)
    );
  }
}
