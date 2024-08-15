import 'package:final_assignment/core/utils/asset_provider.dart';
import 'package:final_assignment/features/authentication/data/model/auth_hive_model.dart';
import 'package:final_assignment/features/authentication/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/authentication/presentation/view/signin_view.dart';
import 'package:final_assignment/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:final_assignment/screen/signin_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPageView extends ConsumerStatefulWidget {
  const SignUpPageView({super.key});
  @override
  ConsumerState<SignUpPageView> createState() => _SignUpPageViewState();
}

class _SignUpPageViewState extends ConsumerState<SignUpPageView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isemailHidden = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Image.asset(
                Assets.images.Logo,
              ),
              const SizedBox(
                  child: Text(
                'Register',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Last Name';
                            }
                            // if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            //     .hasMatch(value)) {
                            //   return 'Please enter a valid last name';
                            // }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.lock),
                            // suffixIcon: IconButton(
                            //   icon: Icon(
                            //     _isemailHidden
                            //         ? Icons.visibility
                            //         : Icons.visibility_off,
                            //   ),
                            //   onPressed: () {
                            //     setState(() {
                            //       _isemailHidden = !_isemailHidden;
                            //     });
                            //   },
                            // ),
                          ),
                          // obscureText: _isemailHidden,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (value.length < 6) {
                              return 'email must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Enter your password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              // await ref.read(authHiveModelProvider.notifier).
                              var user = AuthEntity(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text);

                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .signUpPage(user);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Divider(color: Colors.grey[300], thickness: 1),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SignInPageView())));
                          },
                          child: const Text(
                            'Already have an account? Log In',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performSignUp(
      String firstName, String lastName, String email, String password) {
    // Implement your sign-up logic here
    print('firstName: $firstName');
    print('lastName: $lastName');
    print('email: $email');
    print('password: $password');
  }
}
