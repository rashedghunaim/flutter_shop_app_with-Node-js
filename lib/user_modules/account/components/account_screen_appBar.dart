import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../util/theme.dart';

PreferredSizeWidget accountScreenAppBar({required BuildContext context}) {
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Image.asset(
              'lib/assets/images/amazon_ae.png',
              width: 120,
              color: Colors.black,
            ),
          ),
          Container(
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.only(right: 10),
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
