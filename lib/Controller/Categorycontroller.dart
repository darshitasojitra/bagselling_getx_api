import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Model/Categorymodel.dart';


class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryModel = CategoryModel().obs;

  final String url = "https://physiotherapycenter.mdidminfoway.com/darsita/bagsellingApi/selectBagCategory.php";

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);

      final Map<String, String> body = {
        'user_id': '123', // Replace with actual user ID
        'token': 'abc123', // Replace with actual token
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: body,
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        categoryModel.value = CategoryModel.fromJson(jsonData);
      } else {
        Get.snackbar("Error", "Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Exception: $e");
    } finally {
      isLoading(false);
    }
  }
}
