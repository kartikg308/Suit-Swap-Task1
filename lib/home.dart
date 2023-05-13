import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/rendering/sliver_staggered_grid.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:suitswap/fetch.dart';
import 'package:suitswap/model.dart';
import 'package:suitswap/search.dart';

class ProductsGridView extends StatefulWidget {
  const ProductsGridView({super.key});

  @override
  State<ProductsGridView> createState() => _ProductsGridViewState();
}

class _ProductsGridViewState extends State<ProductsGridView> {
  ProductsWithCategory? productsWithCategory;
  List<Widget> products = [];

  getProducts() async {
    productsWithCategory = await FetchProducts().getSampleProducts();
    log(productsWithCategory!.toJson().toString());
    if (productsWithCategory != null) {
      log("inside if");
      for (var i = 0; i < productsWithCategory!.products!.length; i++) {
        log("inside for loop");
        products.add(
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  productsWithCategory!.products![i].images![0],
                  height: 70,
                ),
                Text(productsWithCategory!.products![i].title!),
                Text(
                  productsWithCategory!.products![i].category!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoTextField(
          placeholder: "Enter category or product name to search",
          onChanged: (value) {
            products = Search().searchProducts(value, productsWithCategory!);
            setState(() {});
          },
        ),
      ),
      body: productsWithCategory?.products != null
          ? StaggeredGridView.builder(
              itemCount: products.length,
              gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                staggeredTileBuilder: (value) {
                  return StaggeredTile.count(
                    2,
                    value % 2 == 0 ? 3 : 2,
                  );
                },
              ),
              itemBuilder: (context, index) {
                return products[index];
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
