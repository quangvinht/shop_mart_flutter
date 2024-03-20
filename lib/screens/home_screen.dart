import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/consts/app_constants.dart';
import 'package:shop_mart/models/category.dart';
import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/providers/products_provider.dart';
import 'package:shop_mart/services/assets_manager.dart';
import 'package:shop_mart/widgets/app_name_text.dart';
import 'package:shop_mart/widgets/products/category_rounded.dart';
import 'package:shop_mart/widgets/products/lastest_arrival.dart';
import 'package:shop_mart/widgets/title_text.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    List<ProductModel> products = ref.watch(productsProvider.notifier).products;

    Widget swipperBanner = SizedBox(
      height: size.height * 0.3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Swiper(
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              AppConstants.bannersImages[index],
              fit: BoxFit.fill,
            );
          },
          itemCount: AppConstants.bannersImages.length,
          pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: Colors.white,
            activeColor: Colors.red,
          )),
          //control: const SwiperControl(),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const AppNameText(
          text: 'Shopping',
          fontSize: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              swipperBanner,
              const SizedBox(
                height: 24,
              ),
              const TitleText(label: 'Lastest arrival'),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, index) {
                      return LastestArrival(
                        product: products[index],
                      );
                    }),
              ),
              const SizedBox(
                height: 24,
              ),
              const TitleText(label: 'Categories'),
              SizedBox(
                height: size.height * 0.3,
                child: GridView.count(
                  crossAxisCount: 4,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  children: AppConstants.categoriesList
                      .map(
                        (CategoriesModel category) => CategoryRounded(
                          key: Key(category.id),
                          image: category.image,
                          name: category.name,
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
