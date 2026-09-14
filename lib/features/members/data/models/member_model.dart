import 'package:online_archive/features/members/domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    required super.registeredDate,
    required super.isActive,
    required super.password,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      registeredDate: DateTime.parse(json['registeredDate'] as String),
      isActive: json['isActive'] as bool,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'registeredDate': registeredDate.toIso8601String(),
      'isActive': isActive,
      'password': password,
    };
  }
}
