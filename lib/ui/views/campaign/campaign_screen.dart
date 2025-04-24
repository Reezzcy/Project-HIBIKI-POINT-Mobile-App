import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_with_attachment_response.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_add_form.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_detail_screen.dart';

class CampaignScreen extends StatefulWidget{
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  List<CampaignWithAttachmentResponse> _campaignWithAttachmentList = dummyCampaignWithAttachmentList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryDarkBlue,
        appBar: _appBarSection(context),
        body: _campaignListSection(),
        floatingActionButton: _floatingButton(context),
      )
    );
  }

  PreferredSizeWidget _appBarSection(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryDarkBlue,
      title: Text(
        'My Campaign',
        style: TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 24.0,
            fontWeight: FontWeight.bold
        ),
      ),
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryWhite)
      )
    );
  }

  Widget _floatingButton(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return CampaignAddForm();
            })
          );
        },
        backgroundColor: AppColors.primaryWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.add, color: AppColors.primaryDarkBlue),
            Text(
              'Create',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primaryDarkBlue,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _campaignListSection() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: _campaignWithAttachmentList.length,
          itemBuilder: (context, index) {
            CampaignWithAttachmentResponse campaign = _campaignWithAttachmentList[index];
            return _campaignItem(campaign);
          },
        ),
      ),
    );
  }

  Widget _campaignItem(CampaignWithAttachmentResponse campaign) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CampaignDetailScreen(campaign: campaign);
        }));
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 16,
                backgroundImage: MemoryImage(
                  base64Decode(campaign.attachment.file)
                )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  campaign.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ),
              Icon(Icons.edit)
            ],
          )
        ),
      ),
    );
  }
}