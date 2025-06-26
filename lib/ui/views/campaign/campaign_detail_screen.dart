import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_response.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import 'package:project_hibiki_point_mobile_app/ui/views/campaign/campaign_edit_form.dart';

class CampaignDetailScreen extends StatefulWidget {
  final CampaignModel campaign;
  final String attachmentFile;

  const CampaignDetailScreen({super.key, required this.campaign, this.attachmentFile = ''});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _appBarSection(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _campaignPicture(screenSize, widget.attachmentFile), // Gambar placeholder
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Description'),
                    _buildSectionContent(widget.campaign.description),

                    _buildSectionTitle('Budget'),
                    _buildSectionContent('Rp. ${widget.campaign.budget}'),

                    _buildSectionTitle('Status'),
                    _buildSectionContent(widget.campaign.status),

                    _buildSectionTitle('Date'),
                    _buildSectionContent(
                        '${_formatDate(widget.campaign.startDate)} - ${_formatDate(widget.campaign.endDate)}'
                    ),
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

  PreferredSizeWidget _appBarSection(BuildContext context) {
    return AppBar(
        title: Text(
          widget.campaign.title,
          style: const TextStyle(
              color: AppColors.primaryBlack,
              fontSize: 24.0,
              fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryBlack)
        )
    );
  }

  Widget _floatingButton(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 50,
      child: FloatingActionButton(
        onPressed: () {
          // --- FUNGSI EDIT DI SINI ---
          // Arahkan ke halaman form edit, kirim data campaign saat ini
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CampaignEditForm(campaignToEdit: widget.campaign);
          }));
        },
        backgroundColor: AppColors.primaryDarkBlue,
        child: const Row(
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

  Widget _campaignPicture(Size screenSize, String attachment) {
    // Gambar placeholder karena tidak ada attachment
    if (attachment != '') {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.memory(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.3,
          fit: BoxFit.cover,
            base64Decode(attachment),
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.25,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.campaign_outlined,
            size: 100,
            color: Colors.grey.shade400,
          ),
        ),
      );
    }
  }

  // Widget helper untuk membuat judul section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Divider(),
        ],
      ),
    );
  }

  // Widget helper untuk membuat konten section
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        content,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    // Pastikan locale 'id_ID' sudah terdaftar di main.dart
    // import 'package:intl/date_symbol_data_local.dart';
    // await initializeDateFormatting('id_ID', null);
    return DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
  }
}
