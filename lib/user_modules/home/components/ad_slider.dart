import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget adSliderSection({required BuildContext context}) {
  final List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];
  return Container(
    child: CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enableInfiniteScroll: true,
        padEnds: true,
        disableCenter: true,
        reverse: false,
        viewportFraction: 1.0,
      ),
      items: carouselImages.map((item) {
        return Builder(
          builder: (context) {
            return Image.network(
              item,
              fit: BoxFit.cover,
              height: 100,
              width: double.infinity,
            );
          },
        );
      }).toList(),
    ),
  );
}
