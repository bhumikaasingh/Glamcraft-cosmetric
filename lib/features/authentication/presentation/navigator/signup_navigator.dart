import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/authentication/presentation/view/signup_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final SignUpViewNavigatorProvider = Provider((ref) => SignUpViewNavigator());

class SignUpViewNavigator {}

mixin SignUpViewRoute {
  openSignUpView() {
    NavigateRoute.pushRoute(const SignUpPageView());
  }
}
