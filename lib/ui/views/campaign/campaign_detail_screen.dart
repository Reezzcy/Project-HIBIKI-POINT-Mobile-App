import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_with_attachment_response.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class CampaignDetailScreen extends StatefulWidget {
  final CampaignModel campaign;

  const CampaignDetailScreen({Key? key, required this.campaign}) : super(key: key);

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    CampaignWithAttachmentResponse campaignWithAttachment;
    if (widget.campaign is CampaignWithAttachmentResponse) {
      campaignWithAttachment = widget.campaign as CampaignWithAttachmentResponse;
    } else {
      campaignWithAttachment = dummyCampaignWithAttachmentList
          .firstWhere((campaign) => campaign.campaignId == widget.campaign.campaignId);
    }

    return Scaffold(
      appBar: _appBarSection(campaignWithAttachment),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _campaignPicture(campaignWithAttachment, _screenSize),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    _descriptionTitle(),
                    _descriptionSection(campaignWithAttachment),
                    _budgetTitle(),
                    _budgetSection(campaignWithAttachment),
                    _statusTitle(),
                    _statusSection(campaignWithAttachment),
                    _dateTitle(),
                    _dateSection(campaignWithAttachment)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _floatingButton(context),
    );
  }

  PreferredSizeWidget _appBarSection(CampaignWithAttachmentResponse campaignWithAttachment) {
    return AppBar(
      title: Text(
        campaignWithAttachment.title,
        style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: 24.0,
            fontWeight: FontWeight.bold
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryBlack)
      )
    );
  }

  Widget _floatingButton(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      child: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: AppColors.primaryDarkBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.edit, color: AppColors.primaryBoneWhite),
            Text(
              'Edit',
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryBoneWhite,
                  fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _campaignPicture(CampaignWithAttachmentResponse campaign, Size _screenSize) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.memory(
          width: _screenSize.width * 0.9,
          height: _screenSize.height * 0.3,
          fit: BoxFit.cover,
          base64Decode(campaign.attachment.file),
        ),
      ),
    );
  }

  Widget _descriptionTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _descriptionSection(CampaignWithAttachmentResponse campaign) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        campaign.description,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 14
        ),
      ),
    );
  }

  Widget _budgetTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Budget',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _budgetSection(CampaignWithAttachmentResponse campaign) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        'Rp. ${campaign.budget}',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16
        ),
      ),
    );
  }

  Widget _statusTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Status',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _statusSection(CampaignWithAttachmentResponse campaign) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        campaign.status,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16
        ),
      ),
    );
  }

  Widget _dateTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Date',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _dateSection(CampaignWithAttachmentResponse campaign) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        '${_formatDate(campaign.startDate)} - ${_formatDate(campaign.endDate)}',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
  }
}