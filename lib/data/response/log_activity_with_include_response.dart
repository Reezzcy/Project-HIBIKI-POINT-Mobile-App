import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';
import 'package:project_hibiki_point_mobile_app/data/models/log_activity_model.dart';
import 'package:project_hibiki_point_mobile_app/data/models/user_model.dart';

class LogActivityWithIncludeResponse extends LogActivityModel {
  final UserModel user;
  final CampaignModel campaign;

  LogActivityWithIncludeResponse({
    required int logId,
    required int userId,
    required int campaignId,
    required String activityType,
    required String activityDescription,
    required this.user,
    required this.campaign,
  }) : super(
    logId: logId,
    userId: userId,
    campaignId: campaignId,
    activityType: activityType,
    activityDescription: activityDescription,
  );
}

List<LogActivityWithIncludeResponse> getLogActivityWithUserAndCampaign() {
  List<LogActivityWithIncludeResponse> logActivityWithIncludes = [];

  for (var log in dummyLogList) {
    // Find user by userId
    UserModel? user = dummyUserList.firstWhere((user) => user.userId == log.userId, orElse: () => UserModel(userId: 0, name: 'Unknown', status: 'Inactive', avatarBase64: ''));

    // Find campaign by campaignId
    CampaignModel? campaign = dummyCampaignList.firstWhere((campaign) => campaign.campaignId == log.campaignId, orElse: () => CampaignModel(campaignId: 0, userId: 0, attachmentId: 0, title: 'Unknown', description: 'No Description', budget: '0', status: 'Draft', startDate: DateTime.now(), endDate: DateTime.now()));

    // Create LogActivityWithIncludeResponse object
    logActivityWithIncludes.add(LogActivityWithIncludeResponse(
      logId: log.logId,
      userId: log.userId,
      campaignId: log.campaignId,
      activityType: log.activityType,
      activityDescription: log.activityDescription,
      user: user,
      campaign: campaign,
    ));
  }

  return logActivityWithIncludes;
}

List<LogActivityWithIncludeResponse> dummyLogWithIncludeList = [
  LogActivityWithIncludeResponse(
    logId: 1,
    userId: 1,
    campaignId: 101,
    activityType: 'Update',
    activityDescription: 'Updated campaign description and budget.',
    user: UserModel(userId: 1, name: 'Alice', status: 'Active', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 101,
      userId: 1,
      attachmentId: 1,
      title: 'Clean Water Project',
      description: 'Provide clean water access to rural villages.',
      budget: '50000000',
      status: 'Published',
      startDate: DateTime(2025, 5, 1),
      endDate: DateTime(2025, 6, 30),
    ),
  ),
  LogActivityWithIncludeResponse(
    logId: 2,
    userId: 2,
    campaignId: 102,
    activityType: 'Create',
    activityDescription: 'Created new campaign draft for education project.',
    user: UserModel(userId: 2, name: 'Bob', status: 'Active', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 102,
      userId: 2,
      attachmentId: 2,
      title: 'Education for All',
      description: 'Distribute school supplies to children in need.',
      budget: '30000000',
      status: 'Draft',
      startDate: DateTime(2025, 6, 1),
      endDate: DateTime(2025, 7, 31),
    ),
  ),
  LogActivityWithIncludeResponse(
    logId: 3,
    userId: 3,
    campaignId: 103,
    activityType: 'Publish',
    activityDescription: 'Published campaign and shared with community.',
    user: UserModel(userId: 3, name: 'Charlie', status: 'Inactive', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 103,
      userId: 3,
      attachmentId: 3,
      title: 'Tree Planting Movement',
      description: 'Plant 10,000 trees in deforested areas.',
      budget: '45000000',
      status: 'Published',
      startDate: DateTime(2025, 5, 15),
      endDate: DateTime(2025, 6, 15),
    ),
  ),
  LogActivityWithIncludeResponse(
    logId: 4,
    userId: 4,
    campaignId: 104,
    activityType: 'Report',
    activityDescription: 'Reported issue with campaign donations.',
    user: UserModel(userId: 4, name: 'Daisy', status: 'Active', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 104,
      userId: 4,
      attachmentId: 4,
      title: 'Food Bank Initiative',
      description: 'Support local food banks with weekly supplies.',
      budget: '25000000',
      status: 'Draft',
      startDate: DateTime(2025, 7, 1),
      endDate: DateTime(2025, 8, 15),
    ),
  ),
  LogActivityWithIncludeResponse(
    logId: 5,
    userId: 5,
    campaignId: 105,
    activityType: 'Update',
    activityDescription: 'Updated budget and added new initiatives.',
    user: UserModel(userId: 5, name: 'Eve', status: 'Do not disturb', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 105,
      userId: 5,
      attachmentId: 5,
      title: 'Mental Health Awareness',
      description: 'Conduct workshops and counseling sessions.',
      budget: '35000000',
      status: 'Published',
      startDate: DateTime(2025, 6, 10),
      endDate: DateTime(2025, 7, 10),
    ),
  ),
  LogActivityWithIncludeResponse(
    logId: 6,
    userId: 1,
    campaignId: 106,
    activityType: 'Create',
    activityDescription: 'Created new homes rebuilding program.',
    user: UserModel(userId: 1, name: 'Alice', status: 'Active', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 106,
      userId: 1,
      attachmentId: 6,
      title: 'Rebuild Homes Program',
      description: 'Assist families in rebuilding homes after floods.',
      budget: '60000000',
      status: 'Published',
      startDate: DateTime(2025, 5, 20),
      endDate: DateTime(2025, 7, 1),
    ),
  ),
  LogActivityWithIncludeResponse(
    logId: 7,
    userId: 2,
    campaignId: 107,
    activityType: 'Publish',
    activityDescription: 'Launched literacy drive for rural youth.',
    user: UserModel(userId: 2, name: 'Bob', status: 'Active', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 107,
      userId: 2,
      attachmentId: 7,
      title: 'Digital Literacy Drive',
      description: 'Teach basic computer skills to rural youth.',
      budget: '28000000',
      status: 'Draft',
      startDate: DateTime(2025, 6, 5),
      endDate: DateTime(2025, 8, 5),
    ),
  ),
  LogActivityWithIncludeResponse(
    logId: 8,
    userId: 3,
    campaignId: 108,
    activityType: 'Report',
    activityDescription: 'Reported progress of disaster relief efforts.',
    user: UserModel(userId: 3, name: 'Charlie', status: 'Inactive', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 108,
      userId: 3,
      attachmentId: 8,
      title: 'Disaster Relief Fund',
      description: 'Provide immediate relief to disaster-hit areas.',
      budget: '40000000',
      status: 'Published',
      startDate: DateTime(2025, 6, 15),
      endDate: DateTime(2025, 7, 15),
    ),
  ),
  LogActivityWithIncludeResponse(
    logId: 9,
    userId: 4,
    campaignId: 109,
    activityType: 'Update',
    activityDescription: 'Updated the program curriculum for empowerment initiatives.',
    user: UserModel(userId: 4, name: 'Daisy', status: 'Active', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 109,
      userId: 4,
      attachmentId: 9,
      title: 'Youth Empowerment Program',
      description: 'Support the empowerment of youth in urban areas.',
      budget: '22000000',
      status: 'Draft',
      startDate: DateTime(2025, 7, 15),
      endDate: DateTime(2025, 8, 30),
    ),
  ),
  LogActivityWithIncludeResponse(
    logId: 10,
    userId: 5,
    campaignId: 110,
    activityType: 'Publish',
    activityDescription: 'Published advocacy campaign for animal protection.',
    user: UserModel(userId: 5, name: 'Eve', status: 'Do not disturb', avatarBase64: avatarBase64),
    campaign: CampaignModel(
      campaignId: 110,
      userId: 5,
      attachmentId: 10,
      title: 'Animal Protection Advocacy',
      description: 'Promote animal rights and welfare.',
      budget: '50000000',
      status: 'Published',
      startDate: DateTime(2025, 5, 10),
      endDate: DateTime(2025, 6, 10),
    ),
  ),
];
