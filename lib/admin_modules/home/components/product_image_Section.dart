import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

Widget addProductImageSection({required BuildContext context}) {
  return DottedBorder(
    borderType: BorderType.RRect,
    radius: Radius.circular(10),
    dashPattern: [10, 4],
    strokeCap: StrokeCap.round,
    child: Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 40,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'select product image',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[400],
            ),
          )
        ],
      ),
    ),
  );
}
