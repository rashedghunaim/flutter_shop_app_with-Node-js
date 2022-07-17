import 'package:amazon_clone/models/sales.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;

class CategoryProductsChart extends StatelessWidget {
  final List<chart.Series<SalesModel, String>> seriesList;
  CategoryProductsChart({required this.seriesList});

  @override
  Widget build(BuildContext context) {
    return chart.BarChart(
      seriesList,
      animate: true,
    );
  }
}
