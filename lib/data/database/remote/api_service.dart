import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'package:project_hibiki_point_mobile_app/data/response/login_google_response.dart';
import 'package:project_hibiki_point_mobile_app/data/response/login_response.dart';
import 'package:project_hibiki_point_mobile_app/data/response/register_reponse.dart';
import 'package:project_hibiki_point_mobile_app/data/response/response_model.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_response.dart';
import 'package:project_hibiki_point_mobile_app/data/response/campaign_list_response.dart';

class ApiService {
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Use 10.0.2.2 for Android emulator to access localhost
  final String _baseUrl = 'https://10.0.2.2:443';

  http.Client _createClient() {
    // For development: accept any certificate
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    
    return IOClient(httpClient);
  }

  // Standard HTTP methods with proper error handling
  Future<ResponseModel> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final client = _createClient();
      final response = await client.get(
        Uri.parse('$_baseUrl$endpoint'),
        headers: headers ?? {'Content-Type': 'application/json'},
      );
      client.close();
      return _processResponse(response);
    } catch (e) {
      print('GET request failed with error: $e');
      throw Exception('GET request failed: $e');
    }
  }

  Future<ResponseModel> post(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    try {
      final client = _createClient();
      print('Sending POST to: $_baseUrl$endpoint');
      print('With data: $data');
      
      final response = await client.post(
        Uri.parse('$_baseUrl$endpoint'),
        body: data is String ? data : json.encode(data),
        headers: headers ?? {'Content-Type': 'application/json'},
      );

      print(1);
      client.close();
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      return _processResponse(response);
    } catch (e) {
      print('POST request failed with error: $e');
      throw Exception('POST request failed: $e');
    }
  }

  Future<ResponseModel> put(String endpoint, dynamic data, {Map<String, String>? headers}) async {
    try {
      final client = _createClient();
      print('Sending PUT to: $_baseUrl$endpoint');

      final response = await client.put(
        Uri.parse('$_baseUrl$endpoint'),
        body: json.encode(data),
        headers: headers ?? {'Content-Type': 'application/json'},
      );

      client.close();
      print('Response status: ${response.statusCode}');
      return _processResponse(response);
    } catch (e) {
      print('PUT request failed with error: $e');
      throw Exception('PUT request failed: $e');
    }
  }

  Future<ResponseModel> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final client = _createClient();
      print('Sending DELETE to: $_baseUrl$endpoint');

      final response = await client.delete(
        Uri.parse('$_baseUrl$endpoint'),
        headers: headers ?? {'Content-Type': 'application/json'},
      );

      client.close();
      print('Response status: ${response.statusCode}');
      return _processResponse(response);
    } catch (e) {
      print('DELETE request failed with error: $e');
      throw Exception('DELETE request failed: $e');
    }
  }

  // Process response and handle errors, wrapping in ResponseModel
  ResponseModel _processResponse(http.Response response) {
    final responseBody = json.decode(response.body);
    print(responseBody);
    // If the API directly returns ResponseModel structure
    if (responseBody is Map<String, dynamic> &&
        responseBody.containsKey('status') &&
        responseBody.containsKey('message')) {

      final responseModel = ResponseModel.fromJson(responseBody);

      // Check status code from the ResponseModel
      if (responseModel.status == 'success' || response.statusCode >= 200 && response.statusCode < 300) {
        return responseModel;
      } else {
        throw Exception(responseModel.message ?? 'Request failed without specific error message');
      }
    }
    // If the API response is not already wrapped in ResponseModel
    else {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Wrap successful response in ResponseModel
        return ResponseModel(
          status: 'success',
          message: 'Success',
          data: responseBody,
        );
      } else {
        // Wrap error response in ResponseModel
        final message = responseBody is Map<String, dynamic>
            ? responseBody['message'] ?? 'Unknown error'
            : 'Request failed with status: ${response.statusCode}';

        throw Exception(message);
      }
    }
  }

  // Authentication specific methods that handle ResponseModel unwrapping
  Future<LoginResponse> fetchPostLogin(Map<String, dynamic> data) async {
    final responseModel = await post('/api/auth/login', data);
    // Extract the data payload from ResponseModel and pass it to the LoginResponse constructor
    return LoginResponse.postAuthLogin(responseModel.data);
  }

  Future<LoginGoogleResponse> fetchPostLoginGoogle(Map<String, dynamic> data) async {
    final responseModel = await post('/api/auth/google/login', data);
    // Extract the data payload from ResponseModel and pass it to the LoginGoogleResponse constructor
    return LoginGoogleResponse.postAuthLoginGoogle(responseModel.data);
  }

  Future<RegisterResponse> fetchPostRegister(Map<String, dynamic> data) async {
    final responseModel = await post('/api/auth/register', data);
    // Extract the data payload from ResponseModel and pass it to the RegisterResponse constructor
    return RegisterResponse.postAuthRegister(responseModel.data);
  }

  Future<CampaignResponse> createCampaign(Map<String, dynamic> campaignData, {String? token,}) async {
    final headers = {'Content-Type': 'application/json', if (token != null) 'Authorization': 'Bearer $token'};
    final responseModel = await post('/api/campaign/', campaignData, headers: headers);

    if (responseModel.data is Map<String, dynamic>) {
      return CampaignResponse.getCampaign(responseModel.data);
    } else {
      throw Exception('Invalid data format received from server');
    }
  }

  Future<CampaignListResponse> fetchAllCampaigns({required String token,}) async {
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    final responseModel = await get('/api/campaign/', headers: headers);

    // Ekstrak payload 'data' dari ResponseModel
    if (responseModel.data is List) {
      return CampaignListResponse.fromData(responseModel.data);
    } else {
      throw Exception('Format data tidak valid untuk daftar campaign');
    }
  }

  Future<CampaignResponse> updateCampaign({required int campaignId, required Map<String, dynamic> campaignData, required String token,}) async {
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    final responseModel = await put('/api/campaign/$campaignId', campaignData, headers: headers);

    if (responseModel.data is Map<String, dynamic>) {
      return CampaignResponse.getCampaign(responseModel.data);
    } else {
      throw Exception('Invalid data format for updated campaign received');
    }
  }

  Future<ResponseModel> deleteCampaign({required int campaignId, required String token,}) async {
    final headers = {'Authorization': 'Bearer $token'};
    return await delete('/api/campaign/$campaignId', headers: headers);
  }
}