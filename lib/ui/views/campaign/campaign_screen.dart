import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_hibiki_point_mobile_app/providers/campaign_provider.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_response.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_add_form.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_detail_screen.dart';

class CampaignScreen extends StatefulWidget{
  const CampaignScreen({super.key});

  @override
  State<CampaignScreen> createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch campaigns when screen initializes
    Future.microtask(() => 
      Provider.of<CampaignProvider>(context, listen: false).fetchCampaigns()
    );
  }

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
      title: const Text(
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
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryWhite)
      )
    );
  }

  Widget _floatingButton(BuildContext context) {
    return SizedBox(
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
        child: const Row(
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
    return Consumer<CampaignProvider>(
      builder: (context, campaignProvider, _) {
        if (campaignProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryWhite),
          );
        }
        
        if (campaignProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${campaignProvider.error}',
                  style: const TextStyle(color: AppColors.primaryWhite),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => campaignProvider.fetchCampaigns(),
                  child: const Text('Try Again'),
                )
              ],
            ),
          );
        }
        
        if (campaignProvider.campaigns.isEmpty) {
          return const Center(
            child: Text(
              'No campaigns found.\nCreate your first campaign!',
              style: TextStyle(color: AppColors.primaryWhite),
              textAlign: TextAlign.center,
            ),
          );
        }
        
        return RefreshIndicator(
          onRefresh: () => campaignProvider.fetchCampaigns(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: campaignProvider.campaigns.length,
              itemBuilder: (context, index) {
                CampaignResponse campaign = campaignProvider.campaigns[index];
                return _campaignItem(campaign);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _campaignItem(CampaignResponse campaign) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => CampaignDetailScreen(campaign: campaign, attachmentFile: campaign.attachment.file))
        ).then((_) {
          // Refresh campaigns when returning from detail screen
          Provider.of<CampaignProvider>(context, listen: false).fetchCampaigns();
        });
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    // Display image if available, otherwise show placeholder
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.primaryDarkBlue.withOpacity(0.5),
                      child: campaign.attachment.file.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.memory(base64Decode(campaign.attachment.file))
                            )
                          : Icon(Icons.campaign, color: AppColors.primaryWhite),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        campaign.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit)
            ],
          ),
        ),
      ),
    );
  }
}