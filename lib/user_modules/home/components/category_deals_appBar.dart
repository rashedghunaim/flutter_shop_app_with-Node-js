import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../util/theme.dart';

PreferredSizeWidget categoryDealsScreenAppBar({
  required BuildContext context,
  required String title,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: AppBar(
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
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
        ),
      ),
      title: Container(
        padding: EdgeInsets.only(right: 20),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
