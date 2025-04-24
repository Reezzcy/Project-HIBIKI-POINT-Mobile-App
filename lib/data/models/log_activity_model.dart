class LogActivityModel {
  final int logId;
  final int userId;
  final int campaignId;
  final String activityType;
  final String activityDescription;

  LogActivityModel({
    required this.logId,
    required this.userId,
    required this.campaignId,
    required this.activityType,
    required this.activityDescription,
  });
}

List<LogActivityModel> dummyLogList = [
  LogActivityModel(
    logId: 1,
    userId: 1,
    campaignId: 101,
    activityType: 'Update',
    activityDescription: 'Updated campaign description and budget.',
  ),
  LogActivityModel(
    logId: 2,
    userId: 2,
    campaignId: 102,
    activityType: 'Create',
    activityDescription: 'Created new campaign draft for education project.',
  ),
  LogActivityModel(
    logId: 3,
    userId: 3,
    campaignId: 103,
    activityType: 'Publish',
    activityDescription: 'Published campaign and shared with community.',
  ),
  LogActivityModel(
    logId: 4,
    userId: 4,
    campaignId: 104,
    activityType: 'Report',
    activityDescription: 'Reported issue with campaign donations.',
  ),
  LogActivityModel(
    logId: 5,
    userId: 5,
    campaignId: 105,
    activityType: 'Update',
    activityDescription: 'Updated campaign strategy and timeline.',
  ),
  LogActivityModel(
    logId: 6,
    userId: 1,
    campaignId: 106,
    activityType: 'Create',
    activityDescription: 'Created new campaign draft for home rebuilding.',
  ),
  LogActivityModel(
    logId: 7,
    userId: 2,
    campaignId: 107,
    activityType: 'Publish',
    activityDescription: 'Published digital literacy drive campaign.',
  ),
  LogActivityModel(
    logId: 8,
    userId: 3,
    campaignId: 108,
    activityType: 'Report',
    activityDescription: 'Reported issue with digital literacy campaign.',
  ),
  LogActivityModel(
    logId: 9,
    userId: 4,
    campaignId: 109,
    activityType: 'Create',
    activityDescription: 'Created new campaign for food bank initiative.',
  ),
  LogActivityModel(
    logId: 10,
    userId: 5,
    campaignId: 110,
    activityType: 'Update',
    activityDescription: 'Updated mental health awareness campaign.',
  ),
];
