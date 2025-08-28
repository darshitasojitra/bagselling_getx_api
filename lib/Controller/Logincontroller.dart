import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/LoginModel.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var loginModel = LoginModel().obs;

  Future<void> loginUser(String email, String password) async {
    isLoading.value = true;

    final url = Uri.parse(
      "https://physiotherapycenter.mdidminfoway.com/darsita/bagsellingApi/ClientLogin.php?email=$email&password=$password",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        loginModel.value = LoginModel.fromJson(jsonData);

        if (loginModel.value.status == true) {
          Get.snackbar("Success", loginModel.value.message ?? "Login Success");
          // Navigate to next screen
        } else {
          Get.snackbar("Error", loginModel.value.message ?? "Login Failed");
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
