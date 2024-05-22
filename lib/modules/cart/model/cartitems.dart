
class CartItem {
  final int price;
  final String title;
  final double discountPercentage;
  final String brand;
  final String category;
  final String image;
  int quantity;

  CartItem({
    required this.price,
    required this.title,
    required this.discountPercentage,
    required this.brand,
    required this.category,
    required this.image,
    required this.quantity,
  });
}
