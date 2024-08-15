import 'package:final_assignment/app/constant/hive_table_constant.dart';
import 'package:final_assignment/features/authentication/data/model/auth_hive_model.dart';
import 'package:final_assignment/screen/signin_page.dart';
import 'package:final_assignment/screen/signup_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters

    //  Hive.registerAdapter(AuthHiveModelAdapter());
  }

  Future<void> signUpPage(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.id, user);
  }

  // Future<List<AuthHiveModel>> getAllStudents() async {
  //   var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.studentBox);
  //   var students = box.values.toList();
  //   box.close();
  //   return students;
  // }

  //Login
  Future<AuthHiveModel?> signInPage(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return user;
  }
}
