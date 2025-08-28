import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/Categorycontroller.dart';
import 'SubcategoryScreen.dart';
import 'cart_screen.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final controller = Get.put(CategoryController());

  int currentindex = 0;

  List<SliderModel> sliderList = [
    SliderModel(image: 'assets/images/slider3.webp'),
    SliderModel(image: 'assets/images/slider.jpeg'),
    SliderModel(image: 'assets/images/slider1.jpeg'),
    SliderModel(image: 'assets/images/slider2.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bag Categories",style: TextStyle(color: Colors.white),),
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
      body: Column(
        children: [
          CarouselSlider(
            items: sliderList.map((slideritem) {
              final imagePath = slideritem.image;

              return Builder(
                builder: (context) {
                  return Image(
                    image: imagePath.startsWith('http')
                        ? NetworkImage(imagePath)
                        : AssetImage(imagePath) as ImageProvider,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 50, color: Colors.red);
                    },
                  );
                },
              );
            }).toList(),

            options: CarouselOptions(
              height: 200,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  currentindex = index;
                });
              },
            ),
          ),
          SizedBox(height: 8,),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: List.generate(sliderList.length, (index)=>buildDot(index)),
),
          SizedBox(height: 20,),
    Center(child: Text("Feature Products",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.left,)),
          Expanded(
            child: Obx(() {
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
                                child: Image.network(
                                  imageUrl!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.broken_image, size: 50, color: Colors.red);
                                  },
                                ),
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
          ),
        ],
      ),
    );
  }
Widget buildDot(int index){
bool isActive=currentindex==index;
return AnimatedContainer(duration: Duration(milliseconds: 300),
margin: EdgeInsets.symmetric(horizontal: 4),
height: isActive?10:8,
width: isActive?10:8,
decoration: BoxDecoration(
color:isActive?Colors.teal:Colors.grey.shade400,
  borderRadius:BorderRadius.circular(20)
),);
}
}

class SliderModel {
  String image;

  SliderModel({required this.image});

  void setImage(String getImage) {
    image = getImage;
  }

  String getImage() {
    return image;
  }
}
