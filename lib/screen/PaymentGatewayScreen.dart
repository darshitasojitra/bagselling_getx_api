import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../Model/ProductDetailModel.dart';

class PaymentGatewayScreen extends StatefulWidget {
  final DetailsData product;

  const PaymentGatewayScreen({super.key, required this.product});

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {

  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External Wallet Selected");
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Payment Method',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: ListTile(
                leading: Image.network(widget.product.image ?? "", width: 60, height: 60, fit: BoxFit.cover),
                title: Text(widget.product.productname ?? ""),
                subtitle: Text("₹${widget.product.sellingprice}"),
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
                int amount = ((widget.product.sellingprice ?? 0) * 100).toInt();
                var options = {
                  'key': 'rzp_test_1DP5mmOlF5G5ag',
                  'amount': amount,
                  'currency': 'INR',
                  'name': 'Bag',
                  'description': 'Bag Purchase',
                  'prefill': {
                    'contact': '9999999999',
                    'email': 'test@example.com',
                  }
                };
                try {
                  razorpay.open(options);
                } catch (e) {
                  debugPrint(e.toString());
                }
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
