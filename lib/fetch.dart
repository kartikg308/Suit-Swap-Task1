import 'package:suitswap/model.dart';
import 'package:suitswap/products.dart';

class FetchProducts {
  getSampleProducts() async {
    var sampleProducts = SampleProducts().products;

    var products = ProductsWithCategory.fromJson(sampleProducts);
    return products;
  }
}
