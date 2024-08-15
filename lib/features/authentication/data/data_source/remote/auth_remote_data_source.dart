import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constant/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/features/authentication/domain/entity/auth_entity.dart';
import 'package:final_assignment/screen/signin_page.dart';
import 'package:final_assignment/screen/signup_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    // authSharedPrefs: ref.read(authSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  // final AuthSharedPrefs authSharedPrefs;

  AuthRemoteDataSource({required this.dio});

  Future<Either<Failure, bool>> signUpPage(AuthEntity user) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "firstName": user.firstName,
          "lastName": user.lastName,
          "email": user.email,
          "password": user.password,
        },
      );
      print(response);
      if (response.statusCode == 200) {
        print(response);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Upload image using multipart
  // Future<Either<Failure, String>> uploadProfilePicture(
  //     File image,
  //     ) async {
  //   try {
  //     // Extract name from path
  //     // c:/user/username/pictures/image.png
  //     String fileName = image.path.split('/').last;
  //
  //     FormData formData = FormData.fromMap(
  //       {
  //         'profilePicture': await MultipartFile.fromFile(
  //           image.path,
  //           filename: fileName,
  //         ),
  //       },
  //     );
  //
  //     Response response = await dio.post(
  //       ApiEndpoints.uploadImage,
  //       data: formData,
  //     );
  //
  //     return Right(response.data["data"]);
  //   } on DioException catch (e) {
  //     return Left(
  //       Failure(
  //         error: e.error.toString(),
  //         statusCode: e.response?.statusCode.toString() ?? '0',
  //       ),
  //     );
  //   }
  // }

  Future<Either<Failure, bool>> signInPage(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // retrieve token
        // print({response.data["data"]["accessToken"]});
        // String token = response.data["data"]["accessToken"];
        // await authSharedPrefs.setAuthToken(token);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Future<Either<Failure, AuthEntity>> getCurrentUser() async {
  //   try {
  //     // Get the token from shared prefs
  //     String? token;
  //     var data = await authSharedPrefs.getAuthToken();
  //     data.fold(
  //           (l) => token = null,
  //           (r) => token = r!,
  //     );

  //     var response = await dio.get(
  //       ApiEndpoints.currentUser,
  //       options: Options(headers: {
  //         'Authorization': 'Bearer $token',
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       GetCurrentUserDto getCurrentUserDto =
  //       GetCurrentUserDto.fromJson(response.data);

  //       return Right(getCurrentUserDto.toEntity());
  //     } else {
  //       return Left(
  //         Failure(
  //           error: response.data["message"],
  //           statusCode: response.statusCode.toString(),
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return Left(
  //       Failure(
  //         error: e.error.toString(),
  //         statusCode: e.response?.statusCode.toString() ?? '0',
  //       ),
  //     );
  //   }
  // }
}
