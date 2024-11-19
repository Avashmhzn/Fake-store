import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store_v2/provider/store_provider.dart';
import 'package:fake_store_v2/route/app_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            AppRoute().navigateToPageList(context);
          },
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: cart.isEmpty
          ? const Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(color: Colors.white),
        ),
      )
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final product = cart[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            color: Colors.blueGrey,
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) =>
                const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
                width: 50,
                height: 50,
              ),
              title: Text(product.title),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  ref.read(cartProvider.notifier).removeFromCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${product.title} removed from cart',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: cart.isNotEmpty
          ? Container(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {

          },
          child: Text('Checkout (${cart.length} items)'),
        ),
      )
          : const SizedBox.shrink(),
    );
  }
}
