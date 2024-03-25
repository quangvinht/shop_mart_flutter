import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_mart/providers/cart_provider.dart';
import 'package:shop_mart/providers/order_provider.dart';
import 'package:shop_mart/providers/products_provider.dart';
import 'package:shop_mart/providers/user_provider.dart';
import 'package:shop_mart/providers/viewed_recently_provider.dart';
import 'package:shop_mart/providers/wishlist_provider.dart';
import 'package:shop_mart/screens/cart/cart_screen.dart';
import 'package:shop_mart/screens/home_screen.dart';
import 'package:shop_mart/screens/profile_screen.dart';
import 'package:shop_mart/screens/search_screen.dart';

class RootScreen extends StatefulWidget {
  static const routeName = '/RootScreen';
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    screens = const [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    controller = PageController(initialPage: currentScreen);
  }

  Future<void> fetchAppData() async {
    try {
      await Future.wait({
        Provider.of<UserProvider>(context, listen: false).fetchUserInfo(),
      });
      await Future.wait({
        Provider.of<OrderProvider>(context, listen: false).fetchOrders(),
        Provider.of<ProductsProvider>(context, listen: false).fetchproducts(),
        Provider.of<CartProvider>(context, listen: false).fetchCart(),
        Provider.of<WishlistProvider>(context, listen: false).fetchWhislist(),
        Provider.of<ViewedProdProvider>(context, listen: false).fetchViewed(),
      });
    } catch (e) {
      print("rootscreen error :$e");
    }
  }

  @override
  void didChangeDependencies() {
    fetchAppData();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: "Home",
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: "Search",
          ),
          NavigationDestination(
            selectedIcon: const Icon(IconlyBold.bag2),
            icon: Badge(
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              label: Text(cartProvider.getCartitems.length.toString()),
              child: const Icon(IconlyLight.bag2),
            ),
            label: "Cart",
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
