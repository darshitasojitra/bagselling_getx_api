import 'package:bagselling_getx_api/screen/productdetails_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/ProductController.dart';
import '../Model/SubcategoryModel.dart';
import 'cart_screen.dart';

class ProductScreen extends StatelessWidget {
   final String subid;
   ProductScreen({super.key, required this.subid});



  final Productcontroller controller = Get.put(Productcontroller());

  @override
  Widget build(BuildContext context) {
    controller.fetchProduct(subid);
    return Scaffold(
      appBar: AppBar(title: Text('Products',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart,color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
            },
          )
        ],),
        body: Obx(() {
          if (controller.isloading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.product.isEmpty) {
            return Center(child: Text("No productss found"));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: controller.product.length,
              itemBuilder: (context, index) {
                final product = controller.product[index];
                return  InkWell(onTap: () {
                //  Get.to(() => ProductDetailScreen(productId: product.id.toString())); // pass your actual product ID
                 Get.to(() => Productdetailsscreen(productid: product.id,)); // pass your actual product ID

                },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.network(
                              product.image.toString(),
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 50, color: Colors.red),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.productname.toString(),
                           // item.subcatname ?? 'No Name',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                /*ListTile(
                  title: Text(product.productname ?? ''),
                  subtitle: Text('₹${product.sellingprice ?? '-'}'),
                );*/
              },
            );
          }
        })

    );
  }
}
