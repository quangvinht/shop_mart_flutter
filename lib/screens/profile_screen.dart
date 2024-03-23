import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_mart/screens/auth/login.dart';
import 'package:shop_mart/screens/inner_screen/viewed_recently.dart';
import 'package:shop_mart/screens/inner_screen/wishlist.dart';
import 'package:shop_mart/screens/loading_manager.dart';
import 'package:shop_mart/services/assets_manager.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';

import '../models/user_model.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../services/my_app_functions.dart';
import '../widgets/app_name_text.dart';
import '../widgets/title_text.dart';
import 'inner_screen/orders/orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  bool _isLoading = true;
  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() async {
        _isLoading = true;
        await userProvider.fetchUserInfo();
      });
    } catch (error) {
      await MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: error.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<UserProvider>(context, listen: true).getUserModel;

    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            AssetsManager.shoppingCart,
          ),
        ),
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: TitlesTextWidget(
                    label: "Please login to have unlimited access",
                  ),
                ),
              ),
              currentUser == null
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  width: 3),
                              image: DecorationImage(
                                image: NetworkImage(
                                  currentUser!.userImage,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitlesTextWidget(label: currentUser!.userName),
                              const SizedBox(
                                height: 6,
                              ),
                              SubtitleTextWidget(label: currentUser!.userEmail)
                            ],
                          )
                        ],
                      ),
                    ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TitlesTextWidget(
                      label: "General",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: currentUser == null ? false : true,
                      child: CustomListTile(
                        text: "All Order",
                        imagePath: AssetsManager.orderSvg,
                        function: () {
                          Navigator.pushNamed(
                            context,
                            OrdersScreenFree.routeName,
                          );
                        },
                      ),
                    ),
                    Visibility(
                      visible: currentUser == null ? false : true,
                      child: CustomListTile(
                        text: "Wishlist",
                        imagePath: AssetsManager.wishlistSvg,
                        function: () {
                          Navigator.pushNamed(context, WishlistScreen.routName);
                        },
                      ),
                    ),
                    CustomListTile(
                      text: "Viewed recently",
                      imagePath: AssetsManager.recent,
                      function: () {
                        Navigator.pushNamed(
                            context, ViewedRecentlyScreen.routName);
                      },
                    ),
                    CustomListTile(
                      text: "Address",
                      imagePath: AssetsManager.address,
                      function: () {},
                    ),
                    const SizedBox(height: 6),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(height: 6),
                    const TitlesTextWidget(
                      label: "Settings",
                    ),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      secondary: Image.asset(
                        AssetsManager.theme,
                        height: 34,
                      ),
                      title: Text(themeProvider.getIsDarkTheme
                          ? "Dark Mode"
                          : "Light Mode"),
                      value: themeProvider.getIsDarkTheme,
                      onChanged: (value) {
                        themeProvider.setDarkTheme(themeValue: value);
                      },
                    ),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30.0,
                      ),
                    ),
                  ),
                  icon: Icon(user == null ? Icons.login : Icons.logout),
                  label: Text(user == null ? "Login" : "Logout"),
                  onPressed: () async {
                    if (user == null) {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    } else {
                      await MyAppFunctions.showErrorOrWarningDialog(
                        context: context,
                        subtitle: "Are you sure you want to SignOut",
                        fct: () async {
                          await FirebaseAuth.instance.signOut();
                          if (!mounted) return;
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        isError: false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: SubtitleTextWidget(label: text),
      leading: Image.asset(
        imagePath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
