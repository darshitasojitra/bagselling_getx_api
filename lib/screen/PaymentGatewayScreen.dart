import 'package:flutter/material.dart';
import '../Model/ProductDetailModel.dart';

class PaymentGatewayScreen extends StatelessWidget {
  final DetailsData product;

  const PaymentGatewayScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: ListTile(
                leading: Image.network(product.image ?? "", width: 60, height: 60, fit: BoxFit.cover),
                title: Text(product.productname ?? ""),
                subtitle: Text("₹${product.sellingprice}"),
              ),
            ),
            SizedBox(height: 30),

            const Text("Choose Payment Option", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),

            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Cash on Delivery"),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Order Placed with Cash on Delivery")),
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("Pay Online"),
              onTap: () {
                // In real app, integrate Razorpay, Stripe, etc.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Redirecting to Online Payment...")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
