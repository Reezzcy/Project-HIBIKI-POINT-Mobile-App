import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_add_form.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_detail_screen.dart';

class CampaignScreen extends StatefulWidget{
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  List<CampaignModel> _campaignList = dummyCampaignList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryDarkBlue,
        appBar: _appBarSection(context),
        body: Column(
          children: [
            _campaignListSection()
          ],
        ),
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
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return CampaignAddForm();
          })
        );
      },
      backgroundColor: AppColors.primaryWhite,
      child: Icon(Icons.add, color: AppColors.primaryDarkBlue),
    );
  }

  Widget _campaignListSection() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _campaignList.length,
          itemBuilder: (context, index) {
            CampaignModel campaign = _campaignList[index];
            return _campaignItem(campaign);
          },
        ),
      ),
    );
  }

  Widget _campaignItem(CampaignModel campaign) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(campaign.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(campaign.description, maxLines: 2, overflow: TextOverflow.ellipsis),
              SizedBox(height: 4),
              Text("Status: ${campaign.status}"),
            ],
          ),
        ),
      ),
    );
  }
}