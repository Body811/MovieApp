import 'package:movie_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  final String? country;
  final String? dateOfBirth;
  final String? profilePictureUrl;

  UserModel({
    required super.uid,
    required super.email,
    required super.username,
    this.country,
    this.dateOfBirth,
    this.profilePictureUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      country: map['country'],
      dateOfBirth: map['dateOfBirth'],
      profilePictureUrl: map['profilePictureUrl']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'country': country,
      'dateOfBirth': dateOfBirth,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}