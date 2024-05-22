import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../Controller/quantitycontroller.dart';


class ProductDetails extends StatelessWidget {
  final String title;
  final double rating;
  final String description;

  final double discountPercentage;
  final int stock;
  final String brand;
  final String category;

  ProductDetails({
    Key? key,
    required this.title,
    required this.rating,
    required this.description,
    required this.discountPercentage,
    required this.stock,
    required this.brand,
    required this.category,
  }) : super(key: key);

  final QuantityController quantityController = Get.put(QuantityController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 10,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[400],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 7, top: 15, right: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RatingBar.builder(
                initialRating: rating.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 25,
                itemPadding: EdgeInsets.symmetric(
                  horizontal: 3,
                ),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.indigo[400],
                ),
                onRatingUpdate: (index) {},
                allowHalfRating: true,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  )
                ]),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          )
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          quantityController.decrement();
                        },
                        icon: const Icon(
                          Icons.remove,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Obx(() => Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            quantityController.quantity.toString(),
                            style: TextStyle(
                              color: Colors.indigo[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        )),
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo[400],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            quantityController.increment();
                          },
                          icon: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[400],
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.indigo[300],
                    fontSize: 19,
                  ),
                ),
                SizedBox(height: 20),
                buildRichText('Discount:', '${discountPercentage.toString()}%'),
                SizedBox(
                  height: 20,
                ),
                buildRichText('Left Only:', '$stock'),
                SizedBox(
                  height: 20,
                ),
                buildRichText('Brand:', brand),
                SizedBox(
                  height: 20,
                ),
                buildRichText('Category:', category),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRichText(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.indigo[400],
          fontSize: 19,
        ),
        children: [
          TextSpan(
            text: label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: value,
          ),
        ],
      ),
    );
  }
}
