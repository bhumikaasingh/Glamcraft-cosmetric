import 'package:final_assignment/core/utils/asset_provider.dart';
import 'package:final_assignment/core/utils/util.dart';
import 'package:final_assignment/features/authentication/presentation/view/signup_view.dart';
import 'package:final_assignment/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:final_assignment/screen/dashboard.dart';
import 'package:final_assignment/screen/signup_page.dart';
import 'package:final_assignment/widgets/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPageView extends ConsumerStatefulWidget {
  const SignInPageView({Key? key}) : super(key: key);

  @override
  _SignInPageViewState createState() => _SignInPageViewState();
}

class _SignInPageViewState extends ConsumerState<SignInPageView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isemailHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(Assets.images.Logo)),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kHorizontalMargin,
                    vertical: kVerticalMargin,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveText(
                        'Login',
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: kHorizontalMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ResponsiveText(
                        'Email',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      const ResponsiveText(
                        'Password',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          filled: true,
                          fillColor: Colors.grey[200],
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isemailHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isemailHidden = !_isemailHidden;
                              });
                            },
                          ),
                        ),
                        obscureText: _isemailHidden,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          if (value.length < 6) {
                            return 'password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: kVerticalMargin,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ResponsiveText('Forget password?'),
                        ],
                      ),
                      SizedBox(height: kHorizontalMargin),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .signInPage(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: kVerticalMargin,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ResponsiveText(
                            "Don't have an account?",
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPageView(),
                                ),
                              );
                            },
                            child: ResponsiveText(
                              ' Sign Up',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: Colors.lightGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle Google sign-in
                              },
                              icon: Image.asset(
                                Assets.images.GoogleLogo,
                                height: 20,
                                width: 20,
                              ),
                              label: const Text('Sign in with Google'),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
