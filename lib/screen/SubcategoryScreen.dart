import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/SubcategoryController.dart';
import 'Productscreen.dart';
import 'cart_screen.dart';

class SubcategoryScreen extends StatelessWidget {
  final String categoryId;

  SubcategoryScreen({super.key, required this.categoryId});

  final SubcategoryController controller = Get.put(SubcategoryController());

  @override
  Widget build(BuildContext context) {
    // Fetch once during screen initialization
    controller.fetchSubcategories(categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Subcategories',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart,color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final subcategories = controller.subcategoryModel.value.data;

        if (subcategories == null || subcategories.isEmpty) {
          return const Center(child: Text("No subcategories found"));
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            itemCount: subcategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              final item = subcategories[index];
              final imageUrl =
                  "${item.image}";

              return InkWell(onTap: () {
                Get.to(() => ProductScreen(subid: item.id.toString(),));
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
                            imageUrl,
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
                          item.subcatname ?? 'No Name',
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
            },
          ),
        );
      }),
    );
  }
}
