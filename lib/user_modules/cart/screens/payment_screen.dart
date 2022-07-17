import 'package:amazon_clone/state_managment/products_bloc/products_cubit.dart';
import 'package:amazon_clone/state_managment/products_bloc/products_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';
import '../../../shared/shared_components.dart';
import '../../../state_managment/auth_bloc/auth_cubit.dart';
import '../../../util/theme.dart';
import '../components/address_screen_appBar.dart';

class PaymentScreen extends StatefulWidget {
  final String totalAmount;
  PaymentScreen({
    required this.totalAmount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final flatBuildingController = TextEditingController();
  final areaController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  List<PaymentItem> _paymentItems = [];
  String addressToBeUsed = '';

  @override
  void initState() {
    _paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    cityController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  void onGooglePayResult(res) {
    if (AuthCubit.getAuthCubit(context).getCurrentUser.address.isEmpty) {
      ProductsCubit.getProductCubit(context).saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }

    ProductsCubit.getProductCubit(context)
        .placeNewOrder(
      context: context,
      address: addressToBeUsed,
      totalPrice: double.parse(widget.totalAmount),
    )
        .then((value) {
      Navigator.pop(context);
    });
  }

  void onPayment({required String currentUserAdress}) {
    addressToBeUsed = '';
    final bool isFormNotEmpty = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isFormNotEmpty) {
      if (_formKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${cityController.text}';
      } else {
        throw Exception('Please enter all the values');
      }
    } else if (currentUserAdress.isNotEmpty) {
      addressToBeUsed = currentUserAdress;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  void testing() {
    if (AuthCubit.getAuthCubit(context).getCurrentUser.address.isEmpty) {
      ProductsCubit.getProductCubit(context).saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }

    ProductsCubit.getProductCubit(context).placeNewOrder(
      context: context,
      address: addressToBeUsed,
      totalPrice: double.parse(widget.totalAmount),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userAddress = AuthCubit.getAuthCubit(context).getCurrentUser.address;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: addressScreenAppbar(context: context),
      body: BlocConsumer<ProductsCubit, ProductsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return false;
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    userAddress.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Latest used address',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200),
                                child: Text(
                                  userAddress,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              // Text(
                              //   'OR',
                              //   style: TextStyle(
                              //       fontSize: 18, color: Colors.black),
                              // ),
                              SizedBox(height: 20),
                            ],
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Flat, House no, Building',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: flatBuildingController,
                            hintText: 'Flat, House no, Building',
                          ),
                          SizedBox(height: 20),
                          Text('Area, Street',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: areaController,
                            hintText: 'Area, Street',
                          ),
                          SizedBox(height: 20),
                          Text('Pincode',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: pinCodeController,
                            hintText: 'Pincode',
                          ),
                          SizedBox(height: 20),
                          Text('City/Town',
                              style: lightTheme.textTheme.headline5!),
                          SizedBox(height: 10),
                          customFormField(
                            controller: cityController,
                            hintText: 'City/Town',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GooglePayButton(
                        paymentItems: _paymentItems,
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 15),
                        style: GooglePayButtonStyle.black,
                        type: GooglePayButtonType.buy,
                        paymentConfigurationAsset: "gpay.json",
                        onPaymentResult: onGooglePayResult,
                        onPressed: () =>
                            onPayment(currentUserAdress: userAddress),
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: customElevatedButton(
                    //     titleColor: Colors.white,
                    //     primaryColor: Colors.teal[300],
                    //     onPressed: () {
                    //       testing();
                    //     },
                    //     title: 'Pay',
                    //   ),
                    // ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
