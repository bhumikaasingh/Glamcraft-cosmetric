import 'package:final_assignment/core/utils/asset_provider.dart';
import 'package:final_assignment/core/utils/util.dart';
import 'package:final_assignment/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:final_assignment/screen/signin_page.dart';
import 'package:final_assignment/widgets/responsive_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    ref.read(splashViewModelProvider.notifier).openSignInView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: kHorizontalMargin, vertical: kVerticalMargin),
                child: Column(
                  children: [
                    Text(
                      'GLAM CRAFT',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                        color: Colors.pinkAccent,
                        fontFamily: 'Helvetica',
                      ),
                    ),
                    Text(
                      'Cosmetic Shop',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w400,
                        color: Colors.purple.shade300,
                        fontFamily: 'Helvetica',
                      ),
                    ),
                    Image.asset(Assets.images.SplashScreen),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(width * 0.5, height * 0.07),
                            backgroundColor: Colors.blue.shade300,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        },
                        child: ResponsiveText('Lets Start'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
