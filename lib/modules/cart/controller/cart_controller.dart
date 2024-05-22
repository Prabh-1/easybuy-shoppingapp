import 'package:get/get.dart';

import '../model/cartitems.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  Map<String, RxInt> itemQuantities = {}; // Map to store quantity for each item
  RxInt totalPrice = 0.obs;

  void totalprice() {
    totalPrice.value = 0; // Reset total price to zero before recalculating
    for (var item in cartItems) {
      totalPrice.value += item.price * item.quantity;
    }
  }




  void addItemToCart(CartItem newItem) {
    bool itemExists = false;
    for (var item in cartItems) {
      if (item.title == newItem.title) {
        item.quantity += newItem.quantity;
        itemQuantities[item.title]?.value = item.quantity; // Update quantity for existing item
        itemExists = true;
        break;
      }
    }
    if (!itemExists) {
      cartItems.add(newItem);
      itemQuantities[newItem.title] = newItem.quantity.obs; // Store quantity for new item
    }
    totalprice();
  }

  void removeItemFromCart(CartItem item) {
    cartItems.remove(item);
    itemQuantities.remove(item.title);
    totalprice();// Remove quantity for removed item
  }

  void incrementQuantity(CartItem item) {
    item.quantity++; // Increment item quantity directly
    itemQuantities[item.title]?.value = item.quantity;
    totalprice();// Update quantity for the item
  }

  void decrementQuantity(CartItem item) {
    if (item.quantity > 1) { // Compare item quantity with 1
      item.quantity--;
      itemQuantities[item.title]?.value = item.quantity; // Update quantity for the item
    }
    totalprice();
  }
}
