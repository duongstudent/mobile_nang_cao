import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/cartModel.dart';

class CartControler extends GetxController {
  var cartItems = <Cart>[].obs;

  void addToCart(List<Cart> item) {
    cartItems.clear();
    cartItems.addAll(item);
  }

  void removeFromCart(Cart item) {
    cartItems.remove(item);
  }
}
