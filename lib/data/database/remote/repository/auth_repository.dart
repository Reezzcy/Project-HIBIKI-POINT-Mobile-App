import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_hibiki_point_mobile_app/data/database/remote/api_service.dart';
import 'package:project_hibiki_point_mobile_app/data/response/login_google_response.dart';
import 'package:project_hibiki_point_mobile_app/data/response/login_response.dart';
import 'package:project_hibiki_point_mobile_app/data/response/register_reponse.dart';

abstract class AuthRepository {
  Future<LoginResponse> loginWithEmailPassword(String email, String password);
  Future<LoginGoogleResponse> loginWithGoogle();
  Future<RegisterResponse> registerUser(String name, String email, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiService _apiService;

  // Konfigurasi yang lebih sederhana dan benar
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile', 'openid'],
    clientId: "161846628307-lg717jtn9230tugd6h4g5huqebqdle95.apps.googleusercontent.com"
  );

  AuthRepositoryImpl(this._apiService);

  @override
  Future<LoginResponse> loginWithEmailPassword(String email, String password) async {
    try {
      final data = {
        'email': email,
        'password': password,
      };
      return await _apiService.fetchPostLogin(data);
    } catch (e) {
      print('Error in loginWithEmailPassword: $e');
      throw Exception('Failed to login: $e');
    }
  }

  @override
  Future<LoginGoogleResponse> loginWithGoogle() async {
    try {
      // First, check if already signed in
      GoogleSignInAccount? currentUser = _googleSignIn.currentUser;
      if (currentUser == null) {
        // Try sign in
        GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          throw Exception('Google sign-in was canceled or failed');
        }
        currentUser = googleUser;
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await currentUser.authentication;
      final String? idToken = googleAuth.idToken;

      // Debug output to see if token is received
      if (idToken != null) {
        print('Received idToken: ${idToken}');
      } else {
        print('Failed to retrieve idToken');
      }

      if (idToken == null) {
        throw Exception('Could not get ID token from Google');
      }

      // Send to your backend
      final data = {
        'id_token': idToken,
      };

      return await _apiService.fetchPostLoginGoogle(data);
    } catch (e) {
      print('Error dalam proses Google Sign-In: $e');
      throw Exception('Failed to login with Google: $e');
    }
  }

  @override
  Future<RegisterResponse> registerUser(String name, String email, String password) async {
    try {
      final data = {
        'name': name,
        'email': email,
        'password': password,
      };
      return await _apiService.fetchPostRegister(data);
    } catch (e) {
      print('Error in registerUser: $e');
      throw Exception('Failed to register: $e');
    }
  }
}

// Create proper singleton for global use
final authRepository = AuthRepositoryImpl(ApiService());