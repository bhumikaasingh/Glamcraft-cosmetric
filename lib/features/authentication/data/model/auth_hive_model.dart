import 'package:final_assignment/app/constant/hive_table_constant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:uuid/uuid.dart';
import 'package:final_assignment/features/authentication/domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';
//dart run build_runner build -d

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? firstName;

  @HiveField(2)
  final String? lastName;

  @HiveField(3)
  final String? email;

  @HiveField(4)
  final String? password;

  // Constructor
  AuthHiveModel({
    String? id,
    this.firstName,
    this.lastName,
    required this.email,
    required this.password,
  }) : id = id ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          id: '',
          firstName: '',
          lastName: '',
          email: '',
          password: '',
        );

  // Convert Hive Object to Entity
  AuthEntity toEntity() => AuthEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
        id: const Uuid().v4(),
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        password: entity.password,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'id: $id, firstName: $firstName, lastName: $lastName, email: $email, password: $password';
  }
}
