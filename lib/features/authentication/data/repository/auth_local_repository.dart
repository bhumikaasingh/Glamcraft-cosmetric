import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/authentication/data/data_source/local/auth_local_data_source.dart';
import 'package:final_assignment/features/authentication/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/authentication/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthLocalRepository(
    ref.read(authLocalDataSourceProvider),
  );
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> login(String email, String password) {
    return _authLocalDataSource.login(email, email);
  }

  @override
  Future<Either<Failure, bool>> register(AuthEntity user) {
    return _authLocalDataSource.register(user);
  }

  // @override
  // Future<Either<Failure, String>> uploadProfilePicture(File file) async {
  //   return const Right("");
  // }
}
