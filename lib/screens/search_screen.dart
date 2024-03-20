import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_mart/models/product.dart';
import 'package:shop_mart/providers/products_provider.dart';
import 'package:shop_mart/services/assets_manager.dart';
import 'package:shop_mart/widgets/app_name_text.dart';
import 'package:shop_mart/widgets/products/product.dart';
import 'package:shop_mart/widgets/title_text.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key, this.category});

  final String? category;

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController searchTextController;
  List<ProductModel> productsSearch = [];

  String text = '';
  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      searchTextController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = ref.watch(productsProvider.notifier).products;
    List<ProductModel> productList = widget.category == null
        ? products
        : ref
            .watch(productsProvider.notifier)
            .findProdctsByCategory(widget.category!);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
          title: AppNameText(
            text: widget.category ?? 'Products',
            fontSize: 20,
          ),
        ),
        body: productList.isEmpty
            ? const Center(
                child: TitleText(label: 'No products found'),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          text = value;
                          productsSearch = ref
                              .watch(productsProvider.notifier)
                              .searchProduct(value, productList);
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          text = value;
                          productsSearch = ref
                              .watch(productsProvider.notifier)
                              .searchProduct(value, productList);
                        });
                      },
                      controller: searchTextController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            searchTextController.clear();
                            setState(() {
                              text = '';
                            });
                          },
                          child: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (text.isNotEmpty && productsSearch.isEmpty)
                      const Center(
                        child: TitleText(label: 'No products found'),
                      ),
                    Expanded(
                      child: DynamicHeightGridView(
                          itemCount: text.isNotEmpty
                              ? productsSearch.length
                              : productList.length,
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          builder: (ctx, index) {
                            return Product(
                              product: text.isNotEmpty
                                  ? productsSearch[index]
                                  : productList[index],
                            );
                          }),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
