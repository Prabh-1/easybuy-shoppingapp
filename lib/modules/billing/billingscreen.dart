
import 'package:country_picker/country_picker.dart';
import 'package:easybuy/modules/billing/pay.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BillingScreen(),
    );
  }
}

class BillingScreen extends StatefulWidget {
  @override
  _BillingScreenState createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  var selectedCountry=RxString("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo[500],
        leading: IconButton( onPressed: () { Get.back(); }, icon: Icon(Icons.arrow_back,color: Colors.white,),),
        title: Text('Shipping Address',style: TextStyle(color: Colors.white,),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 15,),
            Text('Enter Your Details',style: TextStyle(fontSize:20,fontWeight: FontWeight.w500),),
            SizedBox(height: 15,),
            _buildTextField('Email', TextInputType.emailAddress),
            SizedBox(height: 15),
            buildDropdown('country'),
            SizedBox(height: 15),
            _buildTextField('Zip Code', TextInputType.number),
            SizedBox(height: 15),
            _buildTextField('Contact', TextInputType.phone),
            SizedBox(height: 15),
            _buildTextField('Flat,House no,Building,Company,Apartment',TextInputType.text),
            SizedBox(height: 15),
            _buildTextField('City/Town',TextInputType.text),
            SizedBox(height: 15),
            _buildTextField('State',TextInputType.text),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Get.to(Payment());
              },
              style: _buildButtonStyle(Colors.grey),
              child: Text('PAY NOW',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }



  TextFormField _buildTextField(String labelText, TextInputType keyboardType, {TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        prefixIcon: labelText == 'Contact' ? Icon(Icons.phone) : null,
      ),
      keyboardType: keyboardType,
    );
  }
  ButtonStyle _buildButtonStyle(Color borderColor) {
    return ButtonStyle(

      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: borderColor),
        ),
      ),
      minimumSize:MaterialStatePropertyAll<Size>(Size(200, 50)),
      backgroundColor: MaterialStatePropertyAll<Color?>(Colors.indigo[500]),
      overlayColor: MaterialStatePropertyAll<Color?>(Colors.indigo[100]),
      elevation: MaterialStateProperty.all<double>(10),
    );
  }
  Widget buildDropdown(String hintText) {
    void setSelectedCountry(String countryName) {
      selectedCountry.value = countryName; // Update the selected country
    }

    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: Get.context!,
          showPhoneCode: true,
          onSelect: (Country country) {
            print('Selected country: ${country.name}');
            setSelectedCountry(country.name);
          },
        );
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(

          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(10)
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Obx(() => Text(
                selectedCountry.value.isNotEmpty
                    ? selectedCountry.value
                    : hintText,
                style: TextStyle(color: Colors.grey[700]),
              ),
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}