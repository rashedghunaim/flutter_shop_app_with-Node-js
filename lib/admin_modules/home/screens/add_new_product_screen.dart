import 'dart:io';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_cubit.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/add_new_product_appbar.dart';

class AddNewProductsScreen extends StatefulWidget {
  static const routeName = './addNewProduct';

  @override
  State<AddNewProductsScreen> createState() => _AddNewProductsScreenState();
}

class _AddNewProductsScreenState extends State<AddNewProductsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    _productNameController.dispose();
    super.dispose();
  }

  String category = 'Mobiles';
  List<String> productCategories = [
    'Art',
    'Baby',
    'Books',
    'Fashion',
    'Home',
    'Mobiles',
    'Self-Care',
    'Sports',
  ];

  List<File> _selectedImages = [];
  void selectImages() async {
    final resp = await pickImages();
    setState(() {
      _selectedImages = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addNewProductsScreenAppBar(context),
      body: Form(
        key: _formKey,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            children: [
              SizedBox(height: 20),
              _selectedImages.isEmpty
                  ? GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        dashPattern: [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'select product image',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[400],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : CarouselSlider(
                      items: _selectedImages.map((image) {
                        return Builder(
                          builder: (context) {
                            return Image.file(
                              image,
                              fit: BoxFit.cover,
                              height: 200,
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1.0,
                        height: 200,
                      ),
                    ),
              SizedBox(height: 20),
              customFormField(
                controller: _productNameController,
                showHintText: true,
                hintText: 'Product Name',
                inputType: TextInputType.name,
              ),
              SizedBox(height: 10),
              customFormField(
                controller: _descriptionController,
                hintText: 'Product Description',
                showHintText: true,
                inputType: TextInputType.name,
                maxLines: 7,
              ),
              SizedBox(height: 10),
              customFormField(
                controller: _priceController,
                showHintText: true,
                hintText: 'Product Price',
                inputType: TextInputType.number,
              ),
              SizedBox(height: 10),
              customFormField(
                controller: _quantityController,
                showHintText: true,
                hintText: 'Product Quantity',
                inputType: TextInputType.number,
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: category,
                  style: TextStyle(color: Colors.black),
                  // initial value
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: productCategories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Container(
                        child: Text(
                          category,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      category = val!;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              BlocConsumer<AdminTransactionsCubit, AdminTransactionsStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return customElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _selectedImages.isNotEmpty) {
                        AdminTransactionsCubit.getProductCubit(context)
                            .addNewProduct(
                          context: context,
                          productName: _productNameController.text,
                          description: _descriptionController.text,
                          price: int.parse(_priceController.text),
                          quantity: int.parse(_quantityController.text),
                          productImages: _selectedImages,
                          category: category,
                        );
                      }
                    },
                    title: 'Sell',
                  );
                },
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
