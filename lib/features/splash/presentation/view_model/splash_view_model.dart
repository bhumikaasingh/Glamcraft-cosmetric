import 'package:final_assignment/features/splash/presentation/navigator/splash_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, void>((ref) {
  final navigator = ref.read(splashViewNavigatorProvider);
  return SplashViewModel(navigator);
});

class SplashViewModel extends StateNotifier<void> {
  SplashViewModel(this.navigator) : super(null);

  final SplashViewNavigator navigator;

  //Open Login page
  void openSignInView() {
    Future.delayed(const Duration(seconds: 5), () {
      navigator.openSignInView();
    });
  }

  // Later on we will add open home page method here as well
  // void openHomeView() {}
}
