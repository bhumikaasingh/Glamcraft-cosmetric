import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  const AuthEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, password];
}
