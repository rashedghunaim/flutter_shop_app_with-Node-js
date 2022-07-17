import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../util/theme.dart';

PreferredSize addNewProductsScreenAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(70),
    child: AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: IconButton(
          icon: Icon(Icons.keyboard_arrow_left_rounded, size: 40),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: appBarGradient,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          'Add Product',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
