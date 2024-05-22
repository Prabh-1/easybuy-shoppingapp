import 'package:easybuy/modules/billing/billingscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key, required this.totalprice});

  final RxInt totalprice;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.indigo[500],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
            'Total: \$${totalprice.value}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          )),
          Obx(() => ElevatedButton(
            onPressed: totalprice.value > 0 ? () {
              Get.to(()=>BillingScreen());
            } : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(totalprice.value > 0 ? Colors.white : Colors.white.withOpacity(0.5)),
              padding: MaterialStateProperty.all(EdgeInsets.all(10)),
            ),
            child: Row(
              children: [
                Text(
                  'Proceed to Buy',
                  style: TextStyle(
                    color: totalprice.value > 0 ? Colors.indigo[400] : Colors.indigo[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                if (totalprice.value == 0) // Add an icon when the button is disabled
                  Icon(
                    Icons.block, // Disabled icon
                    color: Colors.indigo[300],
                    size: 20,
                  ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
