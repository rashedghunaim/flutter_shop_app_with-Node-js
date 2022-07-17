import 'package:flutter/material.dart';

PreferredSize addressScreenAppbar({required BuildContext context}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(100.0),
    child: Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Buy ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}
