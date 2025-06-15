import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_with_attachment_response.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/home/explore/explore_detail.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<CampaignWithAttachmentResponse> _campaignWithAttachmentList = dummyCampaignWithAttachmentList;

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryDarkBlue,
        appBar: _appBarSection(context),
        body: _exploreListSection(_campaignWithAttachmentList, _screenSize),
      )
    );
  }

  PreferredSizeWidget _appBarSection(BuildContext context) {
    return AppBar(
        backgroundColor: AppColors.primaryDarkBlue,
        title: const Text(
          'Explore',
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
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryWhite)
        )
    );
  }

  Widget _exploreListSection(List<CampaignWithAttachmentResponse> listCampaign, Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: _campaignWithAttachmentList.length,
        itemBuilder: (context, index) {
          CampaignWithAttachmentResponse campaign = _campaignWithAttachmentList[index];
          return _exploreItem(campaign, screenSize);
        }
      ),
    );
  }

  Widget _exploreItem(CampaignWithAttachmentResponse campaign, Size screenSize) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ExploreDetail(campaign: campaign);
        }));
      },
      child: Container(
        height: 250,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: screenSize.width * 0.4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      base64Decode(campaign.attachment.file),
                      fit: BoxFit.cover,
                      height: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        campaign.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          campaign.description,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ExploreDetail(campaign: campaign);
                            }));
                          },
                          child: const Text('Detail'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}