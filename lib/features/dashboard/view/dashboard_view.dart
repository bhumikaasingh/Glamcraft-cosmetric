import 'dart:async';

import 'package:final_assignment/app/navigator/navigator.dart';
// import 'package:final_assignment/core/utils/util.dart';
import 'package:final_assignment/features/authentication/presentation/view/signin_view.dart';
import 'package:final_assignment/features/cart/presentation/view/cart_view.dart';
import 'package:final_assignment/features/home/presentation/view/home_view.dart';
import 'package:final_assignment/features/product/presentation/viewmodel/product_viewmodel.dart';
import 'package:final_assignment/features/profile/presentation/view/profile_view.dart';
import 'package:final_assignment/features/sensors/domain/usecases/double_shake_use_case.dart';
import 'package:final_assignment/features/sensors/domain/usecases/gyroscope_usecase.dart';
import 'package:final_assignment/features/product/presentation/view/shop_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomePageView extends ConsumerStatefulWidget {
  const HomePageView({super.key});

  @override
  ConsumerState<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _searchController = TextEditingController();
  late DoubleShakeDetectorService _doubleShakeDetectorService;

  late GyroscopeService _gyroscopeService;
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;
  int _selectedIndex = 0;

  final List<Widget> bottomScreens = [
    const HomeView(),
    CartView(),
    const ShopView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize shake detection service
    _doubleShakeDetectorService =
        DoubleShakeDetectorService(onShake: _handleShake);
    _doubleShakeDetectorService.startListening();
    _gyroscopeService = GyroscopeService();
    _gyroscopeSubscription = _gyroscopeService.gyroscopeStream.listen((event) {
      // Example: Check if the device is tilted in a specific direction
      if (event.x > 1.0) {
        // Perform an action, e.g., log out
        _logout();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _doubleShakeDetectorService.stopListening();
    _gyroscopeSubscription.cancel();
    _gyroscopeService.dispose();

    super.dispose();
  }

  void _handleShake() {
    _doubleShakeDetectorService.stopListening();
    _logout();
  }

  void _logout() {
    print('shack');
    NavigateRoute.pushRoute(const SignInPageView());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: bottomScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_convenience_store_outlined),
              label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
