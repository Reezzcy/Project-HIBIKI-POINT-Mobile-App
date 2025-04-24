import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';
import 'package:project_hibiki_point_mobile_app/data/models/log_activity_model.dart';
import 'package:project_hibiki_point_mobile_app/data/models/user_model.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_with_attachment_response.dart';
import 'package:project_hibiki_point_mobile_app/data/response/log_activity_with_include_response.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_detail_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/report/report_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/task/task_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserModel user = dummyUser;
  List<LogActivityWithIncludeResponse> _logActivityWithIncludeList = dummyLogWithIncludeList;
  List<CampaignWithAttachmentResponse> _campaignWithAttachmentList = dummyCampaignWithAttachmentList;
  List<CampaignModel> _campaignList = dummyCampaignList;

  final _mapMenu = {
    'Campaign': CampaignScreen(),
    'Task': TaskScreen(),
    'Report': ReportScreen(),
    'Help': CampaignScreen(),
    'Menu 5': CampaignScreen(),
    'Menu 6': CampaignScreen(),
  };

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                _profileSection(_screenSize),
                _menuSection(_screenSize),
                _activityTitleSection(),
                _activitySection(),
                _upcomingTitleSection(),
                _upcomingEventSection()
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _profileSection(Size _screenSize) {
    return Container(
      width: _screenSize.width * 0.9,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundImage: MemoryImage(base64Decode(user.avatarBase64)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _menuSection(Size _screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        width: _screenSize.width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.primaryDarkBlue,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: _screenSize.width * 0.40,
              decoration: BoxDecoration(
                color: AppColors.primaryGray,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _menuIcon('Campaign', Icon(Icons.heart_broken))),
                Expanded(child: _menuIcon('Report', Icon(Icons.note_rounded))),
                Expanded(child: _menuIcon('Menu 5', Icon(Icons.numbers))),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _menuIcon('Task', Icon(Icons.task))),
                Expanded(child: _menuIcon('Help', Icon(Icons.help))),
                Expanded(child: _menuIcon('Menu 6', Icon(Icons.numbers))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuIcon(String menuName, Widget menuIcon) {
    return Card(
      color: AppColors.primaryGray,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return _mapMenu[menuName]!;
            }));
          },
          icon: menuIcon,
        ),
      ),
    );
  }
  
  Widget _activityTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Recenly Activities',
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14
        ),
      ),
    );
  }

  Widget _activitySection() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _logActivityWithIncludeList.length,
        itemBuilder: (context, index) {
          LogActivityWithIncludeResponse logActivity = _logActivityWithIncludeList[index];
          return _activityItem(logActivity);
        }
      )
    );
  }

  Widget _activityItem(LogActivityWithIncludeResponse logActivity) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CampaignDetailScreen(campaign: logActivity.campaign);
        }));
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: 10),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Text(
              logActivity.campaign.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      )
    );
  }

  Widget _upcomingTitleSection() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Upcoming Event',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14
        ),
      ),
    );
  }

  Widget _upcomingEventSection() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          CampaignModel campaign = _campaignList[index];
          return _upcomingItem(campaign);
        }
      ),
    );
  }

  Widget _upcomingItem(CampaignModel campaign) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CampaignDetailScreen(campaign: campaign);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlack.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _formatDate(campaign.endDate),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                _formatMonth(campaign.endDate),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          title: Text(
            campaign.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(
            campaign.status,
            style: const TextStyle(fontSize: 14),
          ),
        )
      )
    );
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('d', 'id_ID').format(dateTime);
  }

  String _formatMonth(DateTime dateTime) {
    return DateFormat('MMM', 'id_ID').format(dateTime);
  }
}
