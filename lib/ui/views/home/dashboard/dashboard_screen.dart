import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:project_hibiki_point_mobile_app/providers/campaign_provider.dart';
import 'package:project_hibiki_point_mobile_app/data/models/user_model.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_response.dart';
import 'package:project_hibiki_point_mobile_app/data/response/log_activity_with_include_response.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_detail_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/notification/notification_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/report/report_screen.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/task/task_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserModel user = dummyUser;
  final List<LogActivityWithIncludeResponse> _logActivityWithIncludeList = dummyLogWithIncludeList;

  @override
  void initState() {
    super.initState();
    // Fetch campaigns when dashboard initializes
    Future.microtask(() => 
      Provider.of<CampaignProvider>(context, listen: false).fetchCampaigns()
    );
  }

  final _mapMenu = {
    'Campaign': const CampaignScreen(),
    'Task': const TaskScreen(),
    'Report': const ReportScreen(),
    'Help': const CampaignScreen(),
    'Menu 5': const CampaignScreen(),
    'Menu 6': const CampaignScreen(),
  };

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: RefreshIndicator(
          onRefresh: () => Provider.of<CampaignProvider>(context, listen: false).fetchCampaigns(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  _profileSection(screenSize),
                  _menuSection(screenSize),
                  _activityTitleSection(),
                  _activitySection(),
                  _upcomingTitleSection(),
                  _upcomingEventSection()
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget _profileSection(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 24,
                backgroundImage: MemoryImage(base64Decode(user.avatarBase64)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Hello!',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const NotificationScreen();
              }));
            },
            icon: const Icon(Icons.notifications, color: AppColors.primaryDarkBlue)
          )
        ],
      ),
    );
  }

  Widget _menuSection(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        width: screenSize.width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.primaryDarkBlue,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: screenSize.width * 0.40,
              decoration: BoxDecoration(
                color: AppColors.primaryWhite,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Consumer<CampaignProvider>(builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.error != null || provider.campaigns.isEmpty) {
                    return const Center(child: Text('No campaigns'));
                  }

                  // Just use the first campaign directly
                  return _sliderCampaign(provider.campaigns.first);
                }
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _menuIcon('Campaign', const Icon(Icons.heart_broken))),
                Expanded(child: _menuIcon('Report', const Icon(Icons.note_rounded))),
                Expanded(child: _menuIcon('Menu 5', const Icon(Icons.numbers))),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _menuIcon('Task', const Icon(Icons.task))),
                Expanded(child: _menuIcon('Help', const Icon(Icons.help))),
                Expanded(child: _menuIcon('Menu 6', const Icon(Icons.numbers))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sliderCampaign(CampaignResponse campaign) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CampaignDetailScreen(campaign: campaign);
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                base64Decode(campaign.attachment.file),
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            flex: 1,
            child: Text(
              campaign.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDarkBlue,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
      child: const Text(
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
      margin: const EdgeInsets.only(top: 10, bottom: 20),
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
        margin: const EdgeInsets.only(right: 10),
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(5),
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
      child: const Text(
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
    return Consumer<CampaignProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        }
        
        if (provider.campaigns.isEmpty) {
          return const Center(child: Text('No upcoming events'));
        }
        
        // Sort campaigns by end date to find upcoming ones
        final upcomingCampaigns = provider.campaigns
          .where((c) => c.endDate.isAfter(DateTime.now()))
          .take(5)
          .toList();
          
        if (upcomingCampaigns.isEmpty) {
          return const Center(child: Text('No upcoming events'));
        }
          
        return Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: upcomingCampaigns.length,
            itemBuilder: (context, index) {
              final campaign = upcomingCampaigns[index];
              return _upcomingItem(campaign);
            }
          ),
        );
      },
    );
  }

  Widget _upcomingItem(CampaignResponse campaign) {
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
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _formatDate(campaign.endDate),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                _formatMonth(campaign.endDate),
                style: const TextStyle(
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
