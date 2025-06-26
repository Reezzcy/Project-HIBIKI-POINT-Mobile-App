import 'package:flutter/material.dart';
import 'package:project_hibiki_point_mobile_app/data/database/remote/repository/campaign_repository.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_response.dart';
import 'package:project_hibiki_point_mobile_app/services/auth_service.dart';

class CampaignProvider extends ChangeNotifier {
  // Menggunakan repository dan service yang sudah dibuat
  final CampaignRepository _repository = campaignRepository;
  final AuthService _authService = authService;

  // Variabel untuk mengelola state UI
  bool _isLoading = false;
  String? _error;
  List<CampaignResponse> _campaigns = [];

  // Getter agar UI bisa mengakses state ini (read-only)
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<CampaignResponse> get campaigns => _campaigns;

  /// READ: Mengambil semua campaign dari backend
  Future<void> fetchCampaigns() async {
    _isLoading = true;
    _error = null;
    notifyListeners(); // Memberi tahu UI bahwa loading dimulai

    try {
      final token = await _authService.getToken();
      if (token == null) throw Exception("Anda belum login");

      final response = await _repository.getAllCampaigns(token);
      _campaigns = response.campaigns;

    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Memberi tahu UI bahwa loading selesai (baik sukses maupun gagal)
    }
  }

  /// CREATE: Membuat campaign baru
  Future<bool> createCampaign(Map<String, dynamic> data) async {
    // Aksi ini biasanya cepat, jadi tidak perlu state loading global
    try {
      final token = await _authService.getToken();
      if (token == null) throw Exception("Anda belum login");

      // Panggil repository untuk membuat data baru
      final response = await _repository.createCampaign(data, token);
      final newCampaign = response;

      // Tambahkan campaign baru ke awal list agar langsung muncul di UI
      _campaigns.insert(0, newCampaign);
      notifyListeners(); // Update UI
      return true; // Mengembalikan true jika sukses

    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false; // Mengembalikan false jika gagal
    }
  }

  /// UPDATE: Memperbarui campaign yang sudah ada
  Future<bool> updateCampaign(int campaignId, Map<String, dynamic> data) async {
    try {
      final token = await _authService.getToken();
      if (token == null) throw Exception("Anda belum login");

      final response = await _repository.updateCampaign(campaignId, data, token);
      final updatedCampaign = response;

      // Cari index dari campaign yang lama di dalam list
      final index = _campaigns.indexWhere((c) => c.campaignId == campaignId);
      if (index != -1) {
        // Ganti data lama dengan data yang sudah diupdate
        _campaigns[index] = updatedCampaign;
        notifyListeners(); // Update UI
      }
      return true;

    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// DELETE: Menghapus campaign
  Future<bool> deleteCampaign(int campaignId) async {
    try {
      final token = await _authService.getToken();
      if (token == null) throw Exception("Anda belum login");

      await _repository.deleteCampaign(campaignId, token);

      // Hapus campaign dari list lokal berdasarkan ID-nya
      _campaigns.removeWhere((c) => c.campaignId == campaignId);
      notifyListeners(); // Update UI
      return true;

    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
