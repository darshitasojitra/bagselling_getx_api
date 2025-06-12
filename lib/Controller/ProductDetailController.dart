/*
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/ProductDetailModel.dart';
import '../model/ProductDetailModel.dart';

class ProductDetailController extends GetxController {
  var isLoading = true.obs;
  var productDetail = <DetailsData>[].obs;

  Future<void> fetchProductDetails(String productId) async {
    try {
      isLoading(true);
      var url = Uri.parse("https://physiotherapycenter.mdidminfoway.com/darsita/bagsellingApi/productDetail.php");

      var response = await http.post(url, body: {'id': productId});
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print("sucess=====>>>> ${response.body}");
        ProductDetailModel model = ProductDetailModel.fromJson(jsonData);
        if (model.status == true && model.data != null) {
          productDetail.assignAll(model.data!);
        } else {
          Get.snackbar("Error", model.message ?? "No data found");
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }
}

*/
