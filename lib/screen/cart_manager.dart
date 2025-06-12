import '../Model/ProductDetailModel.dart';

class CartManager {
  static List<DetailsData> cartItems = [];

  static void addToCart(DetailsData product) {
    cartItems.add(product);
  }

  static void removeFromCart(DetailsData product) {
    cartItems.remove(product);
  }

  static void clearCart() {
    cartItems.clear();
  }
}
