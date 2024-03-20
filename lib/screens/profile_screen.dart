import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/providers/theme_provider.dart';
import 'package:shop_mart/screens/auth/login_screen.dart';
import 'package:shop_mart/screens/inners/order/all_order_screen.dart';
import 'package:shop_mart/screens/inners/viewed_recently_screen.dart';
import 'package:shop_mart/screens/inners/whislist_screen.dart';
import 'package:shop_mart/services/app_function.dart';
import 'package:shop_mart/services/assets_manager.dart';
import 'package:shop_mart/widgets/app_name_text.dart';
import 'package:shop_mart/widgets/list_title.dart';
import 'package:shop_mart/widgets/subtitle_text.dart';
import 'package:shop_mart/widgets/title_text.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkTheme = ref.watch(themeProvider);
    void handleLogout(ctx) async {
      await MyAppFunctions.showErrorOrWarningDialog(
          isError: false,
          context: ctx,
          subtitle: "Confirm logout",
          fct: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => const LoginScreen()));
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        title: const AppNameText(
          text: 'Shopping',
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: TitleText(label: 'Pleas login to you all feature!'),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                          width: 3,
                        ),
                        // image: DecorationImage(
                        //   fit: BoxFit.fill,
                        //   image: NetworkImage(AssetsManager.noAvatar),
                        // ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          label: "Vinh Le",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SubtitleText(
                          title: "quangvinht0036@gmail.com",
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(label: 'General'),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomListTitle(
                    title: 'All orders',
                    imagePath: AssetsManager.orderSvg,
                    onTabTitle: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const AllOrderScreen()));
                    },
                  ),
                  CustomListTitle(
                    title: 'Whislist',
                    imagePath: AssetsManager.wishlistSvg,
                    onTabTitle: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const WhislistScreen()));
                    },
                  ),
                  CustomListTitle(
                    title: 'Viewed Recent',
                    imagePath: AssetsManager.recent,
                    onTabTitle: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const ViewedRecentlyScreen()));
                    },
                  ),
                  CustomListTitle(
                    title: 'Address',
                    imagePath: AssetsManager.address,
                    onTabTitle: () {},
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 1),
                  const TitleText(label: 'Settings'),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    title: Text(isDarkTheme ? "Dark Mode" : "Light Mode"),
                    value: isDarkTheme,
                    secondary: Image.asset(AssetsManager.theme, height: 34),
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).setDarkTheme(value);
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  handleLogout(context);
                },
                icon: const Icon(IconlyLight.logout),
                label: const Text('Log out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
