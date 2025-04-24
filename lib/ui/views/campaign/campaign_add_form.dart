import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class CampaignAddForm extends StatefulWidget {
  @override
  _CampaignAddFormState createState() => _CampaignAddFormState();
}

class _CampaignAddFormState extends State<CampaignAddForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return "${date.day}/${date.month}/${date.year}";
  }

  void _showUploadPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  Text("Upload Files",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Icon(Icons.cloud_upload,
                      size: 60, color: AppColors.primaryDarkBlue),
                  SizedBox(height: 16),
                  Text("Upload Your Files From Your Phone",
                      textAlign: TextAlign.center),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDarkBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child:
                        Text("Upload", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBarSection(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryDarkBlue,
      title: Text(
        'My Campaign',
        style: TextStyle(
          color: AppColors.primaryWhite,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryWhite),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final height = mq.size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBarSection(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.07, vertical: height * 0.03),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField("Title"),
                SizedBox(height: 20),
                _buildTextField("Budget"),
                SizedBox(height: 20),
                _buildTextField("Description", maxLines: 4),
                SizedBox(height: 24),

                // Date Picker Row
                Row(
                  children: [
                    Icon(Icons.access_time, size: 20),
                    SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: _dateButton(_formatDate(_startDate)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text("→"),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: _dateButton(_formatDate(_endDate)),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                OutlinedButton.icon(
                  onPressed: () {
                    _showUploadPopup(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primaryDarkBlue),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: Icon(Icons.attach_file),
                  label: Text("Add Attachment"),
                ),

                SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: height * 0.065,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDarkBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text("Create Campaign",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.primaryDarkBlue),
        filled: true,
        fillColor: AppColors.primaryWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primaryDarkBlue,
          ),
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget _dateButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryDarkBlue)),
      child: Text(text,
          style: TextStyle(fontSize: 14, color: AppColors.primaryDarkBlue)),
    );
  }
}
