import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_with_attachment_response.dart';

class CampaignDetailScreen extends StatefulWidget {
  final CampaignModel campaign;

  const CampaignDetailScreen({Key? key, required this.campaign}) : super(key: key);

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  @override
  Widget build(BuildContext context) {
    CampaignWithAttachmentResponse campaignWithAttachment;
    if (widget.campaign is CampaignWithAttachmentResponse) {
      campaignWithAttachment = widget.campaign as CampaignWithAttachmentResponse;
    } else {
      campaignWithAttachment = dummyCampaignWithAttachmentList
          .firstWhere((campaign) => campaign.campaignId == widget.campaign.campaignId);
    }

    return Scaffold(
      appBar: AppBar(title: Text(campaignWithAttachment.title)),
      body: Column(
        children: [
          Text(campaignWithAttachment.description),
          Text(campaignWithAttachment.attachment.file),
        ],
      ),
    );
  }
}