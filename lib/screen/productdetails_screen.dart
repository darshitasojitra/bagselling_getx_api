import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/ProductDetailModel.dart';
import 'PaymentGatewayScreen.dart';
import 'cart_manager.dart';
import 'cart_screen.dart';

class Productdetailsscreen extends StatefulWidget {
  final productid;

  const Productdetailsscreen({super.key, this.productid, });

  @override
  State<Productdetailsscreen> createState() => _ProductdetailsscreenState();
}

class _ProductdetailsscreenState extends State<Productdetailsscreen> {


  List<DetailsData> productdetailsList = [];
  bool isLoading = true;
  @override
  void initState() {
    fetchProductDetails(widget.productid);
    super.initState();
  }

  Future<void> fetchProductDetails(String categoryId) async {

    final url = Uri.parse("https://physiotherapycenter.mdidminfoway.com/darsita/bagsellingApi/productdeteiles.php");
    try {
      final response = await http.post(url, body: {"id": categoryId});
      if (response.statusCode == 200) {
        final bagSubCaegoryModel = ProductDetailModel.fromJson(jsonDecode(response.body));
        if (bagSubCaegoryModel.status == true) {
          setState(() {
            productdetailsList = bagSubCaegoryModel.data ?? [];
            isLoading = false;
          });

          print("ProductsDetails is a sucessfully====>>>  ${response.body}");
        } else {
          print("No Products found");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print("Failed to fetch Products");
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print("Error fetching Products: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("productDetails"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
            },
          )
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : productdetailsList.isEmpty
          ? const Center(child: Text("No ProductsDetails Available"))
          : Center(
        child: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: productdetailsList.length,
          itemBuilder: (context, index) {
            final subCategory = productdetailsList[index];
            return GestureDetector(
              onTap: (){
               },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          image: DecorationImage(
                            image: NetworkImage(subCategory.image ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        subCategory.productname ?? "No Name",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text("Description: ${subCategory.productdescription ?? "N/A"}"),
                    SizedBox(height: 10),
                    Text("Original Price: ₹${subCategory.originalprice}"),
                    Text(
                      "Selling Price: ₹${subCategory.sellingprice}",
                      style:  TextStyle(color: Colors.green),
                    ),
                    SizedBox(height: 10),
                    Text("Option: ${subCategory.option ?? "-"}"),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        CartManager.addToCart(subCategory);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added to cart")),
                        );
                      },
                      child: Text("Add to Cart"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentGatewayScreen(product: subCategory),
                          ),
                        );
                      },
                      child: Text("Buy Now"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 10),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
