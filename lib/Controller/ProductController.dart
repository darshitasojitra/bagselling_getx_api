import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/Productmodel.dart';

class Productcontroller extends GetxController{
  var product = <ProductData>[].obs;
  var isloading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //fetchProduct();
  }

  void fetchProduct(String subcatid) async{
    try{
      isloading(true);
      final response = await http.post(
          Uri.parse('https://physiotherapycenter.mdidminfoway.com/darsita/bagsellingApi/selectBagProducts.php'),
          body:{
            'id': subcatid,
          }
      );

      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        print("Success Featching Product: ${response.body}");

        final productModel = ProductModel.fromJson(jsonData);
        if(productModel.data != null){
          product.value = productModel.data!;
        }else{
          print("No Product Found");
          product.clear();
        }
      }else {
        print("Failed with status code: ${response.statusCode}");
      }
    } catch(e){
      print("Error fetching subcategories: $e");
    }finally {
      isloading(false);
    }
  }
}