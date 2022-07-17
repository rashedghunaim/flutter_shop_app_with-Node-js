import 'package:amazon_clone/shared/shared_components.dart';
import 'package:flutter/material.dart';

Widget userDetailsSection(
    {required BuildContext context, required String userName}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
    ),
    padding: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0, top: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 7),
          child: RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: Theme.of(context).textTheme.headlineLarge,
              children: [
                TextSpan(
                  text: userName.capitalize(),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.account_circle_rounded,
            color: Colors.black,
            size: 50.0,
          ),
        ),
      ],
    ),
  );
}
