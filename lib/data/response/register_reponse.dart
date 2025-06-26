import 'package:project_hibiki_point_mobile_app/data/models/auth_model.dart';
import 'package:project_hibiki_point_mobile_app/data/models/user_model.dart';

class RegisterResponse extends AuthModel {
  final UserModel user;

  RegisterResponse({
    required super.authId,
    required super.email,
    required super.userId,
    required this.user
  });

  factory RegisterResponse.postAuthRegister(Map<String, dynamic> object) {
    return RegisterResponse(
        user: _parseUser(object['newUser']),
        authId: object['id'],
        email: object['email'],
        userId: object['user_id']
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
        userId: _parseUserId(userObject['user_id']),
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