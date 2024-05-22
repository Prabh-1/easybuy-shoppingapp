import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easybuy/modules/account/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileApp extends StatefulWidget {
  final String? username;
  ProfileApp({Key? key, this.username}) : super(key: key);

  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  final ProfileController _profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUserDetailsFromSharedPref();
  }
  Future<void> getUserDetailsFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userName = prefs.getString('username');
    final String? email = prefs.getString('email');
    final String? contactNumber = prefs.getString('phone_number');

    // Update controller values
    _profileController.setUserName(userName);
    _profileController.setEmail(email);
    _profileController.setContactNumber(contactNumber);

    _userNameController.text = userName ?? '';
    _emailController.text = email ?? '';
    _contactNumberController.text = contactNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.indigo[500],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Obx(
                              () => _profileController.imageFile.value != null
                              ? ClipOval(
                            child: Image.file(
                              _profileController.imageFile.value!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                              : ClipOval(
                            child: widget.username != null &&
                                widget.username!.isNotEmpty
                                ? Center(
                              child: Text(
                                widget.username!
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                ),
                              ),
                            )
                                : Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_isEditing)
                      Positioned(
                        top: 65,
                        right: 105,
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context);
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.indigo,
                            ),
                            child: Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                buildTextFormField('User Name', Icons.person_outline, _userNameController),
                SizedBox(height: 10),
                buildTextFormField('Enter your Email', Icons.mail_outline_rounded, _emailController),
                SizedBox(height: 10),
                buildTextFormField('Contact Number', Icons.phone_in_talk_outlined, _contactNumberController),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Add your Country Code ',
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '"91-", "236-" ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: '(Help)',
                            style: TextStyle(color: Colors.indigo),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                buildDropdown('Country'),
                SizedBox(height: 10),
                buildTextFormField('Complete Address', Icons.home_outlined, null ),
                if (_isEditing)
                  SizedBox(height: 20),
                if (_isEditing)
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save the data
                          _profileController.setUserName(_userNameController.text);
                          _profileController.setEmail(_emailController.text);
                          _profileController.setContactNumber(_contactNumberController.text);
                          setState(() {
                            _isEditing = false;
                          });
                        }
                      },
                      child: Text('Save'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String hintText) {
    return Obx(() => GestureDetector(
      onTap: _isEditing
          ? () {
        showCountryPicker(
          context: Get.context!,
          showPhoneCode: true,
          onSelect: (Country country) {
            print('Selected country: ${country.name}');
            _profileController.setSelectedCountry(country.name);
          },
        );
      }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: _isEditing ? Colors.grey[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hintText == 'Country'
                    ? _profileController.selectedCountry.value.isNotEmpty
                    ? _profileController.selectedCountry.value
                    : hintText
                    : hintText,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            if (_isEditing) Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    ));
  }

  Widget buildTextFormField(String labelText, IconData icon, TextEditingController? controller , ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: _isEditing ? Colors.grey[200] : Colors.grey[300],
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[700]),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        suffixIcon: Icon(icon),
      ),
      style: TextStyle(color: Colors.black),
      readOnly: !_isEditing,
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Select from Gallery'),
                onTap: () {
                  _profileController.selectFromGallery(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Capture an Image'),
                onTap: () {
                  _profileController.captureImage(context);
                },
              ),
              SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
