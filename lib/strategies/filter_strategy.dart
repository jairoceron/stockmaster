import '../models/product.dart';
import '../strategies/filter_strategy.dart';

abstract class FilterStrategy {
  List<Product> apply(List<Product> products, double minPrice, double maxPrice, double minStock);
}

class AndFilterStrategy implements FilterStrategy {
  @override
  List<Product> apply(List<Product> products, double minPrice, double maxPrice, double minStock) {
    return products.where((p) =>
    (p.price ?? 0) >= minPrice &&
        (p.price ?? 0) <= maxPrice &&
        (p.stock ?? 0) >= minStock
    ).toList();
  }
}

class OrFilterStrategy implements FilterStrategy {
  @override
  List<Product> apply(List<Product> products, double minPrice, double maxPrice, double minStock) {
    return products.where((p) =>
    (p.price ?? 0) >= minPrice &&
        (p.price ?? 0) <= maxPrice ||
        (p.stock ?? 0) >= minStock
    ).toList();
  }
}
