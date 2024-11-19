import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store_v2/provider/store_provider.dart';
import 'package:fake_store_v2/route/app_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue = ref.watch(productListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Product List', style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              AppRoute().navigateToCart(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: productAsyncValue.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              margin: const EdgeInsets.all(10.0),
              color: Colors.blueGrey,
              child: ListTile(
                leading: CachedNetworkImage(
                  imageUrl: product.image,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: 50,
                  height: 50,
                ),
                title: Text(product.title),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black),),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    ref.read(cartProvider.notifier).addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.title} added to cart', style: const TextStyle(color: Colors.black),)),
                    );
                  },
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 48, color: Colors.red),
              const SizedBox(height: 8),
              Text('Something went wrong!', style: const TextStyle(color: Colors.white)),
              Text(error.toString(), style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
