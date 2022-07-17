import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget orderOverViewSection({
  required BuildContext context,
  required int date,
  required String orderID,
  required double totalPrice,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'View order details',
        style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
      ),
      SizedBox(height: 10),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Date :    ${DateFormat().format(
                DateTime.fromMillisecondsSinceEpoch(
                  date,
                ),
              )}',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Order ID :         $orderID',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Order Total :    \$$totalPrice',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
