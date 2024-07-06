import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/db_provider.dart';
import 'package:fuel_management_app/Controllers/trip_provider.dart';
import 'package:fuel_management_app/Model/consumer.dart';
import 'package:fuel_management_app/Model/trip.dart';
import 'package:fuel_management_app/UI/Widgets/trip_table.dart';
import 'package:provider/provider.dart';

import 'Widgets/consumers_table.dart';

class ShowTrips extends StatelessWidget {
  const ShowTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          'الرحلات',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            'جدول الرحلات',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Consumer<TripProvider>(builder: (context, provider, x) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Card(
                              shape: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              elevation: 5,
                              child: SingleChildScrollView(
                                child: TripTable(trips: provider.trips ?? []),
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
