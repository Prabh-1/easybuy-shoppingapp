import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/itemcontroller.dart';
import '../../Productdetails/view/ItemPage.dart';

class ItemsWidget extends StatelessWidget {
  final int? limit; // Define the limit parameter
  final String? category; // Define the category parameter

  ItemsWidget({Key? key, this.limit, this.category}) : super(key: key);

  final ItemsController itemsController = Get.put(ItemsController());

  @override
  Widget build(BuildContext context) {
    if (category != null) {
      itemsController.setCategory(category!);
    } else {
      itemsController.clearCategory();
    }

    return Obx(() => GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.68,
        crossAxisCount: 2,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: limit != null
          ? (itemsController.products.length > limit!
          ? limit
          : itemsController.products.length)
          : itemsController.products.length,
      itemBuilder: (context, index) {
        final product = itemsController.products[index];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.indigo[500],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '-${product.discountPercentage.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Obx(() {
                    final isFavorite = itemsController.isProductFavorite(product.id);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red[600],
                      ),
                      onPressed: () {
                        itemsController.toggleFavorite(product.id);
                      },
                    );
                  }),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(() => ItemPage(productId: product.id));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                product.title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.indigo[500],
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 5),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.indigo[500],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[500],
                    ),
                  ),
                  Icon(
                    Icons.shopping_cart_checkout,
                    color: Colors.indigo[500],
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    ));
  }
}
