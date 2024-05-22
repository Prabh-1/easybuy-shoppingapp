import 'package:get/get.dart';

class QuantityController extends GetxController {
  RxInt quantity = 1.obs;

  void increment() {
    if (quantity < 99) {
      quantity++;
    }
  }

  void decrement() {
    if (quantity > 1) {
      quantity--;
    }
  }

}
