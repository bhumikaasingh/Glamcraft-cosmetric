import 'dart:io';

import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/authentication/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/authentication/domain/usecases/auth_usecases.dart';
import 'package:final_assignment/features/authentication/presentation/navigator/signin_navigator.dart';
import 'package:final_assignment/features/authentication/presentation/state/auth_state.dart';
import 'package:final_assignment/screen/signin_page.dart';
import 'package:final_assignment/features/authentication/presentation/view/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(SignInViewNavigatorProvider),
    ref.read(authUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.navigator, this.authUseCase) : super(AuthState.initial());
  final AuthUseCase authUseCase;
  final SignInViewNavigator navigator;

  // Future<void> uploadImage(File? file) async {
  //   state = state.copyWith(isLoading: true);
  //   var data = await authUseCase.uploadProfilePicture(file!);
  //   data.fold(
  //     (l) {
  //       state = state.copyWith(isLoading: false, error: l.error);
  //     },
  //     (imageName) {
  //       state =
  //           state.copyWith(isLoading: false, error: null, imageName: imageName);
  //     },
  //   );
  // }

  Future<void> signUpPage(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.register(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Successfully registered");
      },
    );
  }

  Future<void> signInPage(
    String email,
    String password,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.login(email, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        openHomeView();
        // showMySnackBar(message: "Successfully logged in!");
      },
    );
  }

  void openSignUpView() {
    navigator.openSignUpView();
  }

  void openHomeView() {
    navigator.openDashboardView();
  }
}
