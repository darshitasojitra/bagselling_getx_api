import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart_manager.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartManager.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart (${cartItems.length})"),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Cart is empty"))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final product = cartItems[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(product.image ?? "", width: 50, height: 50),
              title: Text(product.productname ?? "No Name"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selling Price: ₹${product.sellingprice}"),
                  Text("Option: ${product.option ?? "-"}"),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    CartManager.removeFromCart(product);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
