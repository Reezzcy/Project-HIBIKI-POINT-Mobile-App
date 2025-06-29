// import 'package:project_hibiki_point_mobile_app/data/models/attachment_model.dart';
// import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';
//
// class CampaignWithAttachmentResponse extends CampaignModel {
//   final AttachmentModel attachment;
//
//   CampaignWithAttachmentResponse({
//     required super.campaignId,
//     required super.userId,
//     required super.attachmentId,
//     required super.title,
//     required super.description,
//     required super.budget,
//     required super.status,
//     required super.startDate,
//     required super.endDate,
//     required this.attachment,
//   });
// }
//
// List<CampaignWithAttachmentResponse> dummyCampaignWithAttachmentList = [
//   CampaignWithAttachmentResponse(
//     campaignId: 101,
//     userId: 1,
//     attachmentId: 1,
//     title: 'Clean Water Project',
//     description: 'Provide clean water access to rural villages.',
//     budget: '50000000',
//     status: 'Published',
//     startDate: DateTime(2025, 5, 1),
//     endDate: DateTime(2025, 6, 30),
//     attachment: AttachmentModel(attachmentId: 1, file: file, uploadedBy: 1),
//   ),
//   CampaignWithAttachmentResponse(
//     campaignId: 102,
//     userId: 2,
//     attachmentId: 2,
//     title: 'Education for All',
//     description: 'Distribute school supplies to children in need.',
//     budget: '30000000',
//     status: 'Draft',
//     startDate: DateTime(2025, 6, 1),
//     endDate: DateTime(2025, 7, 31),
//     attachment: AttachmentModel(attachmentId: 2, file: file, uploadedBy: 2),
//   ),
//   CampaignWithAttachmentResponse(
//     campaignId: 103,
//     userId: 3,
//     attachmentId: 3,
//     title: 'Tree Planting Movement',
//     description: 'Plant 10,000 trees in deforested areas.',
//     budget: '45000000',
//     status: 'Published',
//     startDate: DateTime(2025, 5, 15),
//     endDate: DateTime(2025, 6, 15),
//     attachment: AttachmentModel(attachmentId: 3, file: file, uploadedBy: 3),
//   ),
//   CampaignWithAttachmentResponse(
//     campaignId: 104,
//     userId: 4,
//     attachmentId: 4,
//     title: 'Food Bank Initiative',
//     description: 'Support local food banks with weekly supplies.',
//     budget: '25000000',
//     status: 'Draft',
//     startDate: DateTime(2025, 7, 1),
//     endDate: DateTime(2025, 8, 15),
//     attachment: AttachmentModel(attachmentId: 4, file: file, uploadedBy: 4),
//   ),
//   CampaignWithAttachmentResponse(
//     campaignId: 105,
//     userId: 5,
//     attachmentId: 5,
//     title: 'Mental Health Awareness',
//     description: 'Conduct workshops and counseling sessions.',
//     budget: '35000000',
//     status: 'Published',
//     startDate: DateTime(2025, 6, 10),
//     endDate: DateTime(2025, 7, 10),
//     attachment: AttachmentModel(attachmentId: 5, file: file, uploadedBy: 5),
//   ),
//   CampaignWithAttachmentResponse(
//     campaignId: 106,
//     userId: 1,
//     attachmentId: 6,
//     title: 'Rebuild Homes Program',
//     description: 'Assist families in rebuilding homes after floods.',
//     budget: '60000000',
//     status: 'Published',
//     startDate: DateTime(2025, 5, 20),
//     endDate: DateTime(2025, 7, 1),
//     attachment: AttachmentModel(attachmentId: 6, file: file, uploadedBy: 1),
//   ),
//   CampaignWithAttachmentResponse(
//     campaignId: 107,
//     userId: 2,
//     attachmentId: 7,
//     title: 'Digital Literacy Drive',
//     description: 'Teach basic computer skills to rural youth.',
//     budget: '28000000',
//     status: 'Draft',
//     startDate: DateTime(2025, 6, 5),
//     endDate: DateTime(2025, 8, 5),
//     attachment: AttachmentModel(attachmentId: 7, file: file, uploadedBy: 2),
//   ),
//   CampaignWithAttachmentResponse(
//     campaignId: 108,
//     userId: 3,
//     attachmentId: 8,
//     title: 'Health Screening Campaign',
//     description: 'Provide free health screenings in rural areas.',
//     budget: '32000000',
//     status: 'Published',
//     startDate: DateTime(2025, 7, 10),
//     endDate: DateTime(2025, 9, 10),
//     attachment: AttachmentModel(attachmentId: 8, file: file, uploadedBy: 3),
//   ),
//   CampaignWithAttachmentResponse(
//     campaignId: 109,
//     userId: 4,
//     attachmentId: 9,
//     title: 'Recycling Initiative',
//     description: 'Encourage recycling in urban areas.',
//     budget: '20000000',
//     status: 'Draft',
//     startDate: DateTime(2025, 8, 1),
//     endDate: DateTime(2025, 9, 15),
//     attachment: AttachmentModel(attachmentId: 9, file: file, uploadedBy: 4),
//   ),
//   CampaignWithAttachmentResponse(
//     campaignId: 110,
//     userId: 5,
//     attachmentId: 10,
//     title: 'Animal Shelter Support',
//     description: 'Provide funding for local animal shelters.',
//     budget: '15000000',
//     status: 'Published',
//     startDate: DateTime(2025, 6, 15),
//     endDate: DateTime(2025, 7, 15),
//     attachment: AttachmentModel(attachmentId: 10, file: file, uploadedBy: 5),
//   ),
// ];
