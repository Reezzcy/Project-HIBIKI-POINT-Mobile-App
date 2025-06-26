import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_hibiki_point_mobile_app/data/models/campaign_model.dart';
import 'package:project_hibiki_point_mobile_app/providers/campaign_provider.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';

class CampaignEditForm extends StatefulWidget {
  // Form ini wajib menerima data campaign yang akan diedit
  final CampaignModel campaignToEdit;

  const CampaignEditForm({super.key, required this.campaignToEdit});

  @override
  _CampaignEditFormState createState() => _CampaignEditFormState();
}

class _CampaignEditFormState extends State<CampaignEditForm> {
  final _formKey = GlobalKey<FormState>();

  // Controller diinisialisasi di initState
  late TextEditingController _titleController;
  late TextEditingController _budgetController;
  late TextEditingController _descriptionController;

  DateTime? _startDate;
  DateTime? _endDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Isi semua controller dan state dengan data dari campaign yang akan diedit
    final campaign = widget.campaignToEdit;
    _titleController = TextEditingController(text: campaign.title);
    _budgetController = TextEditingController(text: campaign.budget);
    _descriptionController = TextEditingController(text: campaign.description);
    _startDate = campaign.startDate;
    _endDate = campaign.endDate;
  }

  Future<void> _handleUpdateCampaign() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() { _isLoading = true; });

    final campaignData = {
      "title": _titleController.text,
      "description": _descriptionController.text,
      "budget": _budgetController.text,
      "status": widget.campaignToEdit.status, // Kirim status yang sama, atau sediakan pilihan
      "start_date": _startDate!.toIso8601String().split('T').first,
      "end_date": _endDate!.toIso8601String().split('T').first,
    };

    final campaignProvider = Provider.of<CampaignProvider>(context, listen: false);
    final success = await campaignProvider.updateCampaign(widget.campaignToEdit.campaignId, campaignData);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Campaign berhasil diperbarui!")));
        // Kembali 2x: sekali dari form edit, sekali dari halaman detail
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui campaign: ${campaignProvider.error}')),
        );
      }
      setState(() { _isLoading = false; });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _budgetController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
                _buildTextField("Title", controller: _titleController),
                const SizedBox(height: 20),
                _buildTextField("Budget", controller: _budgetController, keyboardType: TextInputType.number),
                const SizedBox(height: 20),
                _buildTextField("Description", maxLines: 4, controller: _descriptionController),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: _dateButton(_formatDate(_startDate)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("→"),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: _dateButton(_formatDate(_endDate)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () { /* Fungsi upload attachment jika diperlukan */ },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryDarkBlue),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.attach_file),
                  label: const Text("Change Attachment"),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.065,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleUpdateCampaign,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDarkBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : const Text("Update Campaign",
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

  PreferredSizeWidget _appBarSection(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryDarkBlue,
      title: const Text(
        'Edit Campaign',
        style: TextStyle(
          color: AppColors.primaryWhite,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryWhite),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? _startDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      selectableDayPredicate: isStart ? null : (DateTime day) {
        return _startDate == null ? true : !day.isBefore(_startDate!);
      },
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

  Widget _buildTextField(String label, {int maxLines = 1, TextEditingController? controller, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.primaryDarkBlue),
        filled: true,
        fillColor: AppColors.primaryWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryDarkBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryDarkBlue, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryDarkBlue, width: 2.0),
        ),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget _dateButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryDarkBlue)),
      child: Center(
        child: Text(text,
            style: const TextStyle(fontSize: 14, color: AppColors.primaryDarkBlue)),
      ),
    );
  }
}
