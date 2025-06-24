import 'package:project_hibiki_point_mobile_app/data/models/user_model.dart';

class AuthModel {
  final String authId;
  final String email;
  final String userId;

  AuthModel({
    required this.authId,
    required this.email,
    required this.userId
  });
}