import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:suitswap/model.dart';

class Search {
  searchProducts(String item, ProductsWithCategory productsWithCategory) {
    List<Widget> searchResults = [];
    for (var i = 0; i < productsWithCategory.products!.length; i++) {
      if (productsWithCategory.products![i].title!
              .toLowerCase()
              .contains(item.toLowerCase()) ||
          productsWithCategory.products![i].category!
              .toLowerCase()
              .contains(item.toLowerCase())) {
        searchResults.add(
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  productsWithCategory.products![i].images![0],
                  height: 90,
                ),
                Text(productsWithCategory.products![i].title!),
                Text(
                  productsWithCategory.products![i].category!,
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
    log("found ${searchResults.length}");
    return searchResults;
  }
}
