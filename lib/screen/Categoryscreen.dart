import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/Categorycontroller.dart';
import 'SubcategoryScreen.dart';
import 'cart_screen.dart';

class CategoryScreen extends StatelessWidget {
  late final String categoryId;
  final controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bag Categories"),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen()));
          },
        )
      ],),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final dataList = controller.categoryModel.value.data;

        if (dataList == null || dataList.isEmpty) {
          return Center(child: Text("No categories found"));
        }

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              final imageUrl = item.image!.startsWith('http')
                  ? item.image
                  : "https://physiotherapycenter.mdidminfoway.com/darsita/bagsellingApi/uploads/${item.image}";


              return InkWell(
                onTap: () {
                  print("Tapped category id: ${item.idss}");
                  Get.to(() => SubcategoryScreen(categoryId: item.idss!));
                },

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child:Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image, size: 50, color: Colors.red);
                            },
                          )

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.catname ?? 'No Name',
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
