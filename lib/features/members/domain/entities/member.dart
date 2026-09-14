import 'package:online_archive/core/entities/base_entity.dart';

class Member extends BaseEntity {
  const Member({
    required super.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.registeredDate,
    required this.isActive,
    required this.password,
  });

  final String fullName;
  final String email;
  final String? phoneNumber;
  final DateTime registeredDate;
  final bool isActive;
  final String password;
}
