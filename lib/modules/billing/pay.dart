
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import 'input_formatters.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _cardNumberController = TextEditingController();
  final Rx<CardBrand> _cardBrand = CardBrand.unknown.obs;
  final TextEditingController _upiIdController = TextEditingController();
  bool _isUpiSelected = false;
  bool _isCardSelected = false;
  bool _isCashSelected = false;
  bool _showCashInput = false;
  bool _showUpiInput = false;
  bool _showCardInput = false;
  RxInt month = 5.obs;
  RxInt year = 2024.obs;

  void _toggleCashInput(){
    setState(() {
      _showCashInput = _showCashInput;
      _showUpiInput = false;
      _showCardInput = false;
      _isUpiSelected = false;
      _isCardSelected = false;
      _isCashSelected = true;
    });
  }


  void _toggleUpiInput() {
    setState(() {
      _showUpiInput = !_showUpiInput;
      _showCardInput = false;
      _isUpiSelected = true;
      _isCardSelected = false;
      _isCashSelected = false;// Hide card input when UPI is shown
    });
  }

  void _toggleCardInput() {
    setState(() {
      _showCardInput = !_showCardInput;
      _showUpiInput = false;
      _isUpiSelected = false;
      _isCardSelected = true;
      _isCashSelected = false;// Hide UPI input when card is shown
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
          Get.back();
        },),

        title: Text('Payment',
          style: TextStyle(color: Colors.white),),backgroundColor: Colors.indigo[500],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 26.0),
          child: Column(
            children: [

              _buildDividerWithText('pay with UPI',),
              SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child: _buildPaymentButton(
                      'UPI', Colors.grey, _toggleUpiInput,_isUpiSelected,imagePath: 'assets/images/upi-removebg-preview.png',)
                  ),
                ],
              ),
              if (_showUpiInput)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildTextField('UPI ID', TextInputType.text, controller: _upiIdController,
                    suffixicon:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/upi_2-removebg-preview.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ),

              SizedBox(height: 20,),
              _buildDividerWithText('Or pay with Cash',),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildPaymentButton('CASH', Colors.grey,_toggleCashInput,_isCashSelected)),
                ],
              ),
              SizedBox(height: 20),
              _buildDividerWithText('Or pay with Card'),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _buildPaymentButton('CARD', Colors.grey, _toggleCardInput,_isCardSelected)),
                ],
              ),
              SizedBox(height: 20),
              if (_showCardInput) _buildCardDetailsForm(),
              SizedBox(height: 20),


            ],
          ),
        ),
      ),
      bottomNavigationBar: placeorder(),
    );
  }

  Row placeorder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){},style: ButtonStyle(

            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            minimumSize: MaterialStatePropertyAll<Size>(Size(200,50)),
            backgroundColor: MaterialStatePropertyAll<Color?>(Colors.indigo[500]),
            overlayColor: MaterialStatePropertyAll<Color?>(Colors.indigo[100]),
            elevation: MaterialStateProperty.all<double>(10),
          ),
            child: Text('Place Your Order',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),),
        ),
      ],

    );
  }



  Widget _buildPaymentButton(String text, Color borderColor, VoidCallback onPressed, bool isSelected, {String? imagePath}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: _buildButtonStyle(borderColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Row(
              children: [
                Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18), ),
                if (imagePath != null) Image.asset(imagePath, height: 30, width: 30),
              ],
            ),
            if (isSelected) Spacer(),
            if (isSelected) Icon(Icons.check,color: Colors.white,),
          ],
        ),
      ),
    );
  }


  ButtonStyle _buildButtonStyle(Color borderColor) {
    return ButtonStyle(minimumSize:MaterialStatePropertyAll<Size>(Size(200, 50),),

      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: borderColor),
        ),
      ),
      backgroundColor: MaterialStatePropertyAll<Color?>(Colors.indigo[500]),
      overlayColor: MaterialStatePropertyAll<Color?>(Colors.indigo[100]),
      elevation: MaterialStateProperty.all<double>(10),
    );
  }

  Widget _buildDividerWithText(String text) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1.2)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(text),
        ),
        Expanded(child: Divider(thickness: 1.2)),
      ],
    );
  }
  Widget _buildCardDetailsForm() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0,left: 8),
      child: Column(
        children: [
          SizedBox(height: 20),
          _buildCardInformationField(),
          _buildExpiryDateAndCvcFields(context),
          SizedBox(height: 30),
          _buildTextField('Name on card', TextInputType.text),
        ],
      ),
    );
  }
  TextFormField _buildTextField(String labelText, TextInputType keyboardType, {TextEditingController? controller,Widget? suffixicon,List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        suffixIcon: suffixicon,
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );}



  Widget _buildCardInformationField() {
    return Obx(
          () => TextFormField(
        inputFormatters: [CardNumberInputFormatter()],
        controller: _cardNumberController,
        decoration: InputDecoration(
          hintText: '1234 1234 1234',
          labelText: 'Card Information',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 12.0), // Add padding here
            child: _getCardTypeIcon(),
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          _cardBrand.value = _detectCardType(value);
        },
      ),
    );
  }

  Widget _getCardTypeIcon() {
    switch (_cardBrand.value) {
      case CardBrand.visa:
        return Logo(Logos.visa);
      case CardBrand.masterCard:
        return Logo(Logos.mastercard);
      case CardBrand.amex:
        return Logo(Logos.american_express);
      case CardBrand.discover:
        return Logo(Logos.discover);
      case CardBrand.rupay:
        return Image.asset('assets/images/rupay-removebg-preview.png', height: 30, width: 30);
      default:
        return Icon(Icons.credit_card); // Default icon
    }
  }

  CardBrand _detectCardType(String cardNumber) {
    if (cardNumber.startsWith(RegExp(r'^4[0-9]{0,}$'))) {
      return CardBrand.visa;
    } else if (cardNumber.startsWith(RegExp(r'^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[01]|2720)[0-9]{0,}$'))) {
      return CardBrand.masterCard;
    } else if (cardNumber.startsWith(RegExp(r'^3[47][0-9]{0,}$'))) {
      return CardBrand.amex;
    } else if (cardNumber.startsWith(RegExp(r'^(6011|65|64[4-9]|62212[6-9]|6221[3-9]|622[2-8]|6229[01]|62292[0-5])[0-9]{0,}$'))) {
      return CardBrand.discover;
    } else if (cardNumber.startsWith(RegExp(r'^(508[5-9]|607|6521|60798|60799)[0-9]{0,}$'))) {
      return CardBrand.rupay;
    } else {
      return CardBrand.unknown;
    }
  }

  Widget _buildExpiryDateAndCvcFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(
                () => TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'MM / YY',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    showMonthPicker(
                      context,
                      onSelected: (selectedMonth, selectedYear) {
                        month.value = selectedMonth;
                        year.value = selectedYear;
                      },
                      initialSelectedMonth: month.value,
                      initialSelectedYear: year.value,
                      firstEnabledMonth: 1,
                      lastEnabledMonth: 12,
                      firstYear: 2000,
                      lastYear: 2030,
                      selectButtonText: 'OK',
                      cancelButtonText: 'Cancel',
                      highlightColor: Colors.blue,
                      textColor: Colors.black,
                      contentBackgroundColor: Colors.white,
                      dialogBackgroundColor: Colors.blue[100],
                    );
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ),
              controller: TextEditingController(
                text: '${month.value.toString().padLeft(2, '0')} / ${year.value.toString().substring(2)}',
              ),
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(3)
            ],
            decoration: InputDecoration(
              hintText: 'CVC',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            obscureText: true,
          ),
        ),
      ],
    );
  }
}

enum CardBrand { visa, masterCard, amex, discover, rupay, unknown }