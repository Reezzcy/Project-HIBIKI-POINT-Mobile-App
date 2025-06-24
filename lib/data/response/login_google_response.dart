import 'package:project_hibiki_point_mobile_app/data/models/user_model.dart';

class LoginGoogleResponse {
  final String token;
  final UserModel user;

  LoginGoogleResponse({
    required this.token,
    required this.user
  });

  factory LoginGoogleResponse.postAuthLoginGoogle(Map<String, dynamic> object) {
    // Tampilkan seluruh object untuk debugging
    print('Response Google login full: $object');

    // Parse data dengan cara yang lebih aman
    return LoginGoogleResponse(
      token: object['token'] ?? '',
      user: _parseUser(object['user']),
    );
  }

  // Helper method untuk parsing user dengan aman
  static UserModel _parseUser(dynamic userObject) {
    if (userObject is! Map<String, dynamic>) {
      print('User object bukan Map: $userObject');
      return UserModel(userId: 0, name: '', status: 'Unknown', avatarBase64: '');
    }

    try {
      return UserModel(
        userId: _parseUserId(userObject['id']),
        name: userObject['name'] ?? '',
        status: userObject['status'] ?? 'Active',
        avatarBase64: userObject['avatar_base64'] ?? '',
      );
    } catch (e) {
      print('Error parsing user object: $e');
      return UserModel(userId: 0, name: '', status: 'Error', avatarBase64: '');
    }
  }

  // Helper untuk parse userId dengan aman
  static int _parseUserId(dynamic id) {
    if (id == null) return 0;
    if (id is int) return id;
    if (id is String) return int.tryParse(id) ?? 0;
    return 0;
  }
}