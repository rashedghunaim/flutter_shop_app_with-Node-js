import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

Widget customFormField({
  required final TextEditingController controller,
  final String? hintText,
  final Widget? suffixIcon,
  final TextInputType? inputType,
  bool obscureText = false,
  bool showHintText = false,
  int maxLines = 1,
}) {
  return TextFormField(
    obscureText: obscureText,
    style: TextStyle(color: Colors.black),
    controller: controller,
    keyboardType: inputType,
    cursorColor: Colors.black,
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: showHintText ? hintText : null,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
        ),
      ),
      suffixIcon: suffixIcon,
    ),
    validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'pls enter the $hintText';
      } else {
        return null;
      }
    },
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

Widget customElevatedButton({
  required final void Function() onPressed,
  required final String title,
  final Color? primaryColor,
  double width = double.infinity,
  double height = 50,
  Color? titleColor = Colors.white,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      title,
      style: TextStyle(
        color: titleColor,
      ),
    ),
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
      minimumSize: Size(width, height),
    ),
  );
}

void requestsStatusHandler({
  required Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, json.decode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, json.decode(response.body)['msg']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}

void showSnackBar(BuildContext context, String? text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // duration: Duration(minutes: 5),
      content: Text(text!),
    ),
  );
}

Future pickImage({required ImageSource source}) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
}

Future<List<File>> pickImages() async {
  List<File> _images = [];

  try {
    final files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        _images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    print('image picker error is ' + e.toString());
  }
  return _images;
}

Widget loader() {
  return CircularProgressIndicator();
}

Widget customCarouselSlider({
  required List<String> carouselImages,
  double carouselHeight = 200,
  double imageHeight = 200,
  double imageWidth = double.infinity,
}) {
  return CarouselSlider(
    options: CarouselOptions(
      onPageChanged: (index, reason) {},
      height: carouselHeight,
      viewportFraction: 1.0,
    ),
    items: carouselImages.map((item) {
      return Builder(
        builder: (context) {
          return Image.network(
            item,
            fit: BoxFit.contain,
            height: imageHeight,
            width: imageWidth,
          );
        },
      );
    }).toList(),
  );
}

Widget customProgressIndecator() {
  // final bool isCurrentModeDark = CashHelper.getSavedCashData(key: 'userLatestThemeMode');
  return Center(
    child: CircularProgressIndicator(
      color: Colors.grey[600],
      strokeWidth: 0.8,
    ),
  );
}
