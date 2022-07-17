import 'package:amazon_clone/models/order_model.dart';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_cubit.dart';
import 'package:amazon_clone/state_managment/auth_bloc/auth_cubit.dart';
import 'package:flutter/material.dart';

class OrderTrackingSection extends StatefulWidget {
  final OrderModel order;
  OrderTrackingSection({required this.order});
  @override
  State<OrderTrackingSection> createState() => _OrderTrackingSectionState();
}

class _OrderTrackingSectionState extends State<OrderTrackingSection> {
  int _currentStep = 0;
  @override
  void initState() {
    _currentStep = widget.order.status;
    super.initState();
  }

  void changeOrderStatusByAdmin(int currentStep) {
    AdminTransactionsCubit.getProductCubit(context).changeOrderStatus(
      context: context,
      currentStatus: currentStep + 1,
      orderID: widget.order.id,
      onSuccess: () {
        setState(() {
          _currentStep += 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tracking',
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
        ),
        SizedBox(height: 5),
        Container(
          child: Theme(
            data: ThemeData(
              primarySwatch: Colors.teal,
            ),
            child: Stepper(
              currentStep: _currentStep,
              controlsBuilder: (context, details) {
                if (AuthCubit.getAuthCubit(context).getCurrentUser.type ==
                    'admin') {
                  return customElevatedButton(
                    height: 30,
                    width: 220,
                    onPressed: () {
                      changeOrderStatusByAdmin(details.currentStep);
                    },
                    title: 'Done',
                  );
                }
                return SizedBox();
              },
              physics: BouncingScrollPhysics(),
              steps: [
                Step(
                  isActive: _currentStep >= 0,
                  state: _currentStep >= 0
                      ? StepState.complete
                      : StepState.indexed,
                  title: Text(
                    'Pending',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  content: Text(
                    'Your order is yet to be delivered.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Step(
                  isActive: _currentStep > 1,
                  state:
                      _currentStep > 1 ? StepState.complete : StepState.indexed,
                  title: Text(
                    'Completed',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  content: Text(
                    'Your order has been delivered, you are yet to sign.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Step(
                  isActive: _currentStep > 2,
                  state:
                      _currentStep > 2 ? StepState.complete : StepState.indexed,
                  title: Text(
                    'Recieved',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  content: Text(
                    'Your order is yet to be delivered and signed by you.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Step(
                  isActive: _currentStep >= 3,
                  state: _currentStep >= 3
                      ? StepState.complete
                      : StepState.indexed,
                  title: Text(
                    'Delivered',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  content: Text(
                    'Your order is yet to be delivered and signed by you.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
