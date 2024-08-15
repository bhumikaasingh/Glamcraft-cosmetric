import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/dashboard/view/dashboard_view.dart';

class HomePageViewNavigator {}

mixin HomePageViewRoute {
  openDashboardView() {
    NavigateRoute.pushRoute(const HomePageView());
  }
}
