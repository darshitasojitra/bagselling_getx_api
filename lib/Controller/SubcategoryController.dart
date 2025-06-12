import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/SubcategoryModel.dart';

class SubcategoryController extends GetxController {
  var isLoading = true.obs;
  var subcategoryModel = SubcategoryModel().obs;

  Future<void> fetchSubcategories(String categoryId) async {

    isLoading.value = true;
    final url =
        'https://physiotherapycenter.mdidminfoway.com/darsita/bagsellingApi/selectBagsubcategories.php';

    try {
      final response = await http.post(Uri.parse(url),body: {
        'id':categoryId,

      });
      print("Subcategory API Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        subcategoryModel.value = SubcategoryModel.fromJson(jsonBody);
        print("Fetched subcategories: ${subcategoryModel.value.data?.length ?? 0}");
      } else {
        print("Failed to load subcategories");

      }
    } catch (e) {
      print("Exception while fetching subcategories: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
