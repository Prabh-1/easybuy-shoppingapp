import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var imageFile = Rx<File?>(null);
  var selectedCountry = RxString("");
  RxString userName = ''.obs;
  RxString email = ''.obs;
  RxString contactNumber = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userName = prefs.getString('username');
    final String? email = prefs.getString('email');
    final String? contactNumber = prefs.getString('phone_number');

    // Update controller values
    setUserName(userName);
    setEmail(email);
    setContactNumber(contactNumber);
  }

  void setUserName(String? name) {
    userName.value = name ?? '';
  }

  void setEmail(String? emailAddress) {
    email.value = emailAddress ?? '';
  }

  void setContactNumber(String? number) {
    contactNumber.value = number ?? '';
  }

  void setImageFile(File? file) {
    imageFile.value = file;
  }

  void setSelectedCountry(String countryName) {
    selectedCountry.value = countryName;
  }

  Future<void> selectFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Navigator.pop(context); // Close the bottom sheet
      File? croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        setImageFile(croppedFile);
      }
    }
    Navigator.pop(context);
  }

  Future<void> captureImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      Navigator.pop(context); // Close the bottom sheet
      File? croppedFile = await _cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        setImageFile(croppedFile);
      }
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepPurple,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );
    if (croppedFile != null) {
      // Convert CroppedFile to File
      final convertedFile = File(croppedFile.path);
      return convertedFile;
    } else {
      return null;
    }
  }
}
