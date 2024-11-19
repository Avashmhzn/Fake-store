
import 'package:fake_store_v2/models/product_model.dart';
import 'package:fake_store_v2/repositories/store_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storeRepositoryProvider = Provider((ref) => StoreRepository());

final productListProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(storeRepositoryProvider);
  return repository.fetchProducts();
});

final categoryListProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(storeRepositoryProvider);
  return repository.fetchCategories();
});

final cartProvider = StateNotifierProvider<CartNotifier, List<Product>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    state = [...state, product];
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.id != product.id).toList();
  }
}
