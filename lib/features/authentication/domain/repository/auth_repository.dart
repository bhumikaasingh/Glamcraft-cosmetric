import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';

import 'package:final_assignment/features/authentication/data/repository/auth_remote_repository.dart';
import 'package:final_assignment/features/authentication/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.read(authRemoteRepositoryProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> register(AuthEntity user);
  Future<Either<Failure, bool>> login(String email, String password);
  // Future<Either<Failure, String>> uploadProfilePicture(File file);
}
