import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/models/cart.dart';
import 'package:shop_mart/providers/carts_provider.dart';
import 'package:shop_mart/screens/carts/cart_screen.dart';
import 'package:shop_mart/screens/home_screen.dart';
import 'package:shop_mart/screens/profile_screen.dart';
import 'package:shop_mart/screens/search_screen.dart';

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> {
  late List<Widget> screens;
  int currentIndex = 3;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    screens = const [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen()
    ];
    controller = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    List<CartsModel> carts = ref.watch(cartsProvider);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        height: kBottomNavigationBarHeight + 10,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
          controller.jumpToPage(currentIndex);
        },
        destinations: [
          const NavigationDestination(
              icon: Icon(IconlyLight.home), label: "Home"),
          const NavigationDestination(
              icon: Icon(IconlyLight.search), label: "Search"),
          NavigationDestination(
              icon: Badge(
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                label: Text('${carts.length}'),
                child: const Icon(
                  IconlyLight.bag2,
                ),
              ),
              label: "Cart"),
          const NavigationDestination(
              icon: Icon(IconlyLight.profile), label: "Profile"),
        ],
      ),
    );
  }
}
