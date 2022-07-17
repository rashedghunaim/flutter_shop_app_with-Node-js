import 'package:amazon_clone/models/sales.dart';
import 'package:amazon_clone/shared/shared_components.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_cubit.dart';
import 'package:amazon_clone/state_managment/admin_bloc/admin_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/category_products_chart.dart';
import 'package:charts_flutter/flutter.dart' as chart;

class AdminAnalyticsScreen extends StatefulWidget {
  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
  List<SalesModel>? _earnings;
  int? totalEarnings;

  void collectEarnings() async {
    final Map<String, dynamic> res =
        await AdminTransactionsCubit.getProductCubit(context)
            .collectEarnings(context: context);

    _earnings = res['sales'];
    totalEarnings = res['total_earnings'];
  }

  @override
  void initState() {
    collectEarnings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminTransactionsCubit, AdminTransactionsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return totalEarnings == null || _earnings == null
            ? Center(
                child: loader(),
              )
            : Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total Earnings',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 30),
                        Text(
                          '\$$totalEarnings',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 500,
                      width: double.infinity,
                      child: CategoryProductsChart(
                        
                        seriesList: [
                          chart.Series(
                            id: 'sales',
                            data: _earnings!,
                            domainFn: (SalesModel sales, _) => sales.label,
                            measureFn: (SalesModel sales, _) => sales.earnings,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
