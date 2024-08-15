import 'package:final_assignment/features/authentication/presentation/navigator/signin_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

 
 
final splashViewNavigatorProvider =
    Provider<SplashViewNavigator>((ref) => SplashViewNavigator());
 
class SplashViewNavigator with SignInViewRoute {}
 
mixin SplashViewRoute {}
 