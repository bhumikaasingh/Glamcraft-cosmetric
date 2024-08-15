import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/authentication/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/authentication/domain/usecases/auth_usecases.dart';
import 'package:final_assignment/features/authentication/presentation/navigator/signin_navigator.dart';
import 'package:final_assignment/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_unit_test.mocks.dart';
 

 
@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<SignInViewNavigator>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
 
  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late SignInViewNavigator mockSignInViewNavigator;
 
  setUp(
    () {
      mockAuthUsecase = MockAuthUseCase();
      mockSignInViewNavigator = MockSignInViewNavigator();
      container = ProviderContainer(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockSignInViewNavigator, mockAuthUsecase),
          )
        ],
      );
    },
  );
 
  test('check for the inital state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });
 
  group('SignInPageView Test', () {
    test('SignInPageView test with invalid email and password', () async {
      // Arrange
      when(mockAuthUsecase.login('bhumi1@gmail.com', '123456'))
          .thenAnswer((_) => Future.value(const Right(true)));
 
      when(mockAuthUsecase.login('bhumi12@gmail.com', 'invalidpass'))
          .thenAnswer((_) => Future.value(
                Left(
                  Failure(error: 'Invalid Credentails'),
                ),
              ));
 
      // Act
      await container
          .read(authViewModelProvider.notifier)
          .signInPage('bhumi1@gmail.com', '123456');
 
      final authState = container.read(authViewModelProvider);
 
      // Assert
      expect(authState.error, isNull);
    });
 
    test('SignInPageView test with valid email and password', () async {
      // Arrange
      const email = 'bhumi1@gmail.com';
      const password = '123456';
 
      when(mockAuthUsecase.login(email, password)).thenAnswer((invocation) {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(email == email && password == password
            ? const Right(true)
            : Left(Failure(error: 'Invalid')));
      });
 
      // Act
      await container
          .read(authViewModelProvider.notifier)
          .signInPage('bhumi1@gmail.com', '123456');
 
      final authState = container.read(authViewModelProvider);
 
      // Assert
      expect(authState.error, isNull);
    });
  });
 
  test('SignUpPageView User', () async {
    // Arrange
    const firstName = 'gg ';
    const lastName = 'gg';
    const email = 'bhumi1@gmail.com';
    const password = '123456';
 
    const user = AuthEntity(
        firstName: firstName, lastName: lastName, email: email, password: password);
 
    when(mockAuthUsecase.register(user))
        .thenAnswer((_) => Future.value(const Right(true)));
 
    // Act
    await container.read(authViewModelProvider.notifier).signUpPage(user);
 
    final authState = container.read(authViewModelProvider);
 
    // Assert
    expect(authState.error, isNull);
  });
 
  tearDown(
    () {
      container.dispose();
    },
  );
}