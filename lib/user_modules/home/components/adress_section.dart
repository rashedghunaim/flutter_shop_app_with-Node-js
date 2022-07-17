import 'package:amazon_clone/state_managment/auth_bloc/auth_cubit.dart';
import 'package:flutter/material.dart';

Widget addressSection({required BuildContext context}) {
  return Container(
    height: 40.0,
    decoration: BoxDecoration(
      // gradient: dileverToGradient,
      color: Colors.grey.shade300,
    ),
    padding: EdgeInsets.only(left: 12.0),
    child: Row(
      children: [
        Icon(
          Icons.location_pin,
          size: 20.0,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 5.0,
          ),
          child: Text(
            AuthCubit.getAuthCubit(context).getCurrentUser.address.isEmpty
                ? 'Deliver to United Arab Emartes'
                : '${AuthCubit.getAuthCubit(context).getCurrentUser.address}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 5,
            top: 2,
          ),
          child: Icon(
            Icons.keyboard_arrow_down_sharp,
            size: 18.0,
          ),
        )
      ],
    ),
  );
}
