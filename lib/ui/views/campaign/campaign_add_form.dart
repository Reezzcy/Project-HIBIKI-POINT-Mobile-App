import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_hibiki_point_mobile_app/res/colors.dart';
import '../../../data/database/remote/api_service.dart';
import 'package:project_hibiki_point_mobile_app/providers/auth_provider.dart';

class CampaignAddForm extends StatefulWidget {
  const CampaignAddForm({super.key});

  @override
  _CampaignAddFormState createState() => _CampaignAddFormState();
}

class _CampaignAddFormState extends State<CampaignAddForm> {
  final _formKey = GlobalKey<FormState>();

  // 1. Tambahkan TextEditingController untuk setiap field
  final _titleController = TextEditingController();
  final _budgetController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  // 2. Tambahkan state untuk loading
  bool _isLoading = false;

  // 3. Buat fungsi untuk menangani submit
  Future<void> _handleCreateCampaign() async {
    // Validasi form terlebih dahulu
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Validasi tanggal
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both start and end dates.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. DAPATKAN TOKEN DARI AUTH_PROVIDER, BUKAN DARI SharedPreferences LANGSUNG
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final String? token = authProvider.token;

      // 2. PERIKSA APAKAH TOKEN ADA DI PROVIDER
      if (token == null || token.isEmpty) {
        throw Exception("Authentication token not found in provider. Please login again.");
      }

      // Siapkan data untuk dikirim ke API
      final campaignData = {
        // "user_id": 1, // Ganti dengan user_id yang relevan (jika perlu dikirim dari client)
        "title": _titleController.text,
        "description": _descriptionController.text,
        "budget": _budgetController.text,
        "status": "Draft",
        // Format tanggal ke string "YYYY-MM-DD"
        "start_date": _startDate!.toIso8601String().split('T').first,
        "end_date": _endDate!.toIso8601String().split('T').first,
      };

      // Panggil ApiService
      final apiService = ApiService();
      final response = await apiService.createCampaign(
        campaignData,
        token: token
      );

      // Tampilkan pesan sukses dan kembali ke halaman sebelumnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Campaign "${response.campaign.title}" created successfully!')),
      );
      Navigator.pop(context, true); // Kirim 'true' untuk menandakan sukses

    } catch (e) {
      // Tangani error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create campaign: $e')),
      );
    } finally {
      // Pastikan state loading dihentikan
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Jangan lupa dispose controller
    _titleController.dispose();
    _budgetController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // --- Kode UI Anda yang lain (tidak berubah) ---
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? _startDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      // Validasi tambahan agar end date tidak sebelum start date
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
                  const SizedBox(height: 10),
                  const Text("Upload Files",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  const Icon(Icons.cloud_upload,
                      size: 60, color: AppColors.primaryDarkBlue),
                  const SizedBox(height: 16),
                  const Text("Upload Your Files From Your Phone",
                      textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDarkBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child:
                    const Text("Upload", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.red),
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
      title: const Text(
        'My Campaign',
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
                // 4. Hubungkan controller ke TextFormField
                _buildTextField("Title", controller: _titleController),
                const SizedBox(height: 20),
                _buildTextField("Budget", controller: _budgetController, keyboardType: TextInputType.number),
                const SizedBox(height: 20),
                _buildTextField("Description", maxLines: 4, controller: _descriptionController),
                const SizedBox(height: 24),

                // Date Picker Row
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
                  onPressed: () {
                    _showUploadPopup(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryDarkBlue),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.attach_file),
                  label: const Text("Add Attachment"),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: height * 0.065,
                  child: ElevatedButton(
                    // 5. Hubungkan fungsi _handleCreateCampaign ke tombol
                    onPressed: _isLoading ? null : _handleCreateCampaign, // Nonaktifkan tombol saat loading
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDarkBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    // Tampilkan loading indicator atau text
                    child: _isLoading
                        ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : const Text("Create Campaign",
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

  // Modifikasi _buildTextField untuk menerima controller
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
          borderSide: const BorderSide(
            color: AppColors.primaryDarkBlue,
          ),
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
      validator: (value) =>
      value == null || value.isEmpty ? 'Please enter $label' : null,
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
