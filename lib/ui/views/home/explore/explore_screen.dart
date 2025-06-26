import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_hibiki_point_mobile_app/providers/campaign_provider.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_response.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/home/explore/explore_detail.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryDarkBlue,
        appBar: _appBarSection(context),
        body: _exploreListSection(screenSize),
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

  Widget _exploreListSection(Size screenSize) {
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
              'No campaigns available to explore',
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
                return _exploreItem(campaign, screenSize);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _exploreItem(CampaignResponse campaign, Size screenSize) {
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
                    child: campaign.attachment.file.isNotEmpty
                      ? Image.memory(
                          base64Decode(campaign.attachment.file),
                          fit: BoxFit.cover,
                          height: double.infinity,
                        )
                      : Container(
                          color: Colors.grey.shade300,
                          height: double.infinity,
                          child: const Icon(Icons.image_not_supported, size: 50),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}