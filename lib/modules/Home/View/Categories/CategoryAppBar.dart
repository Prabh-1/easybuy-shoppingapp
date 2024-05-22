import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryAppBar extends StatelessWidget {
   const CategoryAppBar({super.key, required this.category});
  final String category;


  @override
  Widget build(BuildContext context) {
    String capitalizedCategory = category.substring(0, 1).toUpperCase() + category.substring(1);
    return Container(
      padding: EdgeInsets.only(top: 15),
      height: 100,
      color: Colors.indigo[500],
      child: Row(
        children: [
          IconButton(onPressed: (){
            Get.back();
          },
              icon: Icon(Icons.arrow_back,color: Colors.white,),),
          Text(capitalizedCategory,style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),)
        ],
      ),
    );
  }
}
