import 'package:amazon_clone/shared/custom_page_route.dart';
import 'package:flutter/material.dart';
import '../../../assets/icons/my_icons.dart';
import '../screens/search_screen.dart';

AppBar homeScreenAppBar({
  required BuildContext context,
  required bool activateSearchApi,
}) {
  return AppBar(
    // backgroundColor: Colors.transparent,
    title: SizedBox(
      height: 50,
      width: double.infinity,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(70),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(70),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              MyIcons.qr_scan,
              color: Colors.black54,
            ),
          ),
          prefixIcon: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 06.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
                size: 23.0,
              ),
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade300,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(70),
            borderSide: BorderSide(
              color: Colors.black38,
              width: 1.0,
            ),
          ),
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          hintText: 'search ',
        ),
        onFieldSubmitted: activateSearchApi == true
            ? (String query) {
                Navigator.push(
                  context,
                  CustomPageRoute(
                    child: SearchScreen(
                      searchQuery: query,
                    ),
                    direction: AxisDirection.right,
                  ),
                );
              }
            : null,
      ),
    ),
  );
}
