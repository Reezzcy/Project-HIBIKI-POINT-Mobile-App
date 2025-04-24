class CampaignModel {
  final int campaignId;
  final int userId;
  final int attachmentId;
  final String title;
  final String description;
  final String budget;
  final String status;
  final DateTime startDate;
  final DateTime endDate;

  CampaignModel({
    required this.campaignId,
    required this.userId,
    required this.attachmentId,
    required this.title,
    required this.description,
    required this.budget,
    required this.status,
    required this.startDate,
    required this.endDate,
  });
}

List<CampaignModel> dummyCampaignList = [
  CampaignModel(
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
  CampaignModel(
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
  CampaignModel(
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
  CampaignModel(
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
  CampaignModel(
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
  CampaignModel(
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
  CampaignModel(
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
  CampaignModel(
    campaignId: 108,
    userId: 3,
    attachmentId: 8,
    title: 'Community Health Project',
    description: 'Promote health education in rural communities.',
    budget: '40000000',
    status: 'Published',
    startDate: DateTime(2025, 5, 10),
    endDate: DateTime(2025, 6, 10),
  ),
  CampaignModel(
    campaignId: 109,
    userId: 4,
    attachmentId: 9,
    title: 'Climate Action Campaign',
    description: 'Raising awareness about climate change.',
    budget: '45000000',
    status: 'Draft',
    startDate: DateTime(2025, 6, 15),
    endDate: DateTime(2025, 8, 15),
  ),
  CampaignModel(
    campaignId: 110,
    userId: 5,
    attachmentId: 10,
    title: 'Recycling Initiative',
    description: 'Encourage recycling and sustainable living.',
    budget: '35000000',
    status: 'Published',
    startDate: DateTime(2025, 7, 1),
    endDate: DateTime(2025, 8, 1),
  ),
];
