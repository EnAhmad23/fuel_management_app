import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Controllers/db_provider.dart';
import 'package:fuel_management_app/Controllers/op_provider.dart';
import 'package:fuel_management_app/Controllers/sub_provider.dart';
import 'package:fuel_management_app/Controllers/trip_provider.dart';
import 'package:fuel_management_app/UI/add.dart';
import 'package:fuel_management_app/UI/addTrip.dart';
import 'package:fuel_management_app/UI/add_operation_sarf.dart';
import 'package:fuel_management_app/UI/add_subconsumer.dart';
import 'package:fuel_management_app/UI/search_operation.dart';
import 'package:fuel_management_app/UI/showConsumers.dart';
import 'package:fuel_management_app/UI/add_operation_estrad.dart';
import 'package:fuel_management_app/UI/show_available_fuel.dart';
import 'package:fuel_management_app/UI/show_operation.dart';
import 'package:fuel_management_app/UI/show_subOperation.dart';
import 'package:fuel_management_app/UI/show_subconsumer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Widgets/home_page_card.dart';
import 'Widgets/operationTable.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // OpProvider().getLastTenOpT();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 3,
          centerTitle: true,
          title: Text(
            'الصفحة الرئيسية',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black),
          ),
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'المحروقات',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const Divider(),
                ExpansionTile(
                  title: Text(
                    'المستهلكين الرئيسين',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  children: [
                    Consumer<DbProvider>(builder: (context, provider, x) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShowConsumers(),
                              ));
                          provider.getConsumerForTable();
                        },
                        title: Text(
                          'عرض',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.remove_red_eye_outlined,
                            color: Colors.white),
                      );
                    }),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Add(),
                            ));
                      },
                      title: Text(
                        'إضافة',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                      leading: const Icon(Icons.person_add_alt_1,
                          color: Colors.white),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    'المستهلكين الفرعين',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  children: [
                    Consumer<SubProvider>(builder: (context, provider, x) {
                      return ListTile(
                        onTap: () {
                          provider.getSubConsumerT();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ShowSubconsumer(),
                              ));
                        },
                        title: Text(
                          'عرض',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.remove_red_eye_outlined,
                            color: Colors.white),
                      );
                    }),
                    Consumer<SubProvider>(builder: (context, provider, x) {
                      return ListTile(
                        onTap: () {
                          provider.getConsumersNames();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddSubconsumer(),
                              ));
                        },
                        title: Text(
                          'إضافة',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.person_add_alt_1,
                            color: Colors.white),
                      );
                    }),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    'العمليات',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                  leading: const Icon(Icons.settings, color: Colors.white),
                  children: [
                    Consumer<OpProvider>(builder: (context, opPro, x) {
                      return ListTile(
                        onTap: () {
                          opPro.getAllOpT();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ShowOperation(),
                          ));
                        },
                        title: Text(
                          'عرض',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.remove_red_eye_outlined,
                            color: Colors.white),
                      );
                    }),
                    ExpansionTile(
                      title: Text(
                        'إضافة',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                      leading: const Icon(Icons.add_box_outlined,
                          color: Colors.white),
                      children: [
                        Consumer<OpProvider>(builder: (context, provider, x) {
                          return ListTile(
                            onTap: () {
                              provider.getConsumersNames();
                              Get.to(const AddSarf());
                            },
                            title: Text('صرف',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white)),
                            leading: const Icon(Icons.arrow_upward,
                                color: Colors.white),
                          );
                        }),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddOperationEstrad(),
                                ));
                          },
                          title: Text('وارد',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white)),
                          leading: const Icon(Icons.arrow_downward,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    'الرحلات',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                  leading: const Icon(Icons.emoji_flags, color: Colors.white),
                  children: [
                    Consumer<OpProvider>(builder: (context, opPro, x) {
                      return ListTile(
                        onTap: () {
                          opPro.getAllOpT();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ShowOperation(),
                          ));
                        },
                        title: Text(
                          'عرض',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.remove_red_eye_outlined,
                            color: Colors.white),
                      );
                    }),
                    Consumer<TripProvider>(builder: (context, pro, x) {
                      return ListTile(
                        onTap: () {
                          pro.getConusmersNames();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddTrip(),
                          ));
                        },
                        title: Text(
                          'إضافة',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                        leading: const Icon(Icons.add_box_outlined,
                            color: Colors.white),
                      );
                    })
                  ],
                ),
                Consumer<OpProvider>(builder: (context, provider, x) {
                  return ListTile(
                    onTap: () {
                      provider.getConsumersNames();
                      Get.to(const SearchOperation());
                    },
                    title: Text('بحث',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white)),
                    leading:
                        const Icon(Icons.search_rounded, color: Colors.white),
                  );
                }),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'نظام إدارة المحروقات',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Consumer<OpProvider>(builder: (context, op, x) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomePageCard(
                        onPress: () {
                          op.getFuelAvailable();
                          Get.to(const ShowAvailableFuel());
                        },
                        backgroundColor: Colors.yellow,
                        icon: Icons.window,
                        mainText: '${op.totalAvailable}',
                        unitText: ' (لتر)  ',
                        subText: 'إجمالي المتوفر',
                        textColor: Colors.black,
                        iconColor: Colors.yellow[700],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      HomePageCard(
                        onPress: () {
                          op.setSubTitle('عمليات الوارد ');
                          op.getTotalSubOP('وارد');
                          Get.to(const ShowSubOperation());
                        },
                        backgroundColor: Colors.cyan,
                        icon: Icons.arrow_downward_outlined,
                        mainText: '${op.totalWard}',
                        unitText: ' (لتر)  ',
                        subText: 'إجمالي الوارد',
                        textColor: Colors.white,
                        iconColor: Colors.cyan[700],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Consumer<OpProvider>(builder: (context, op, x) {
                        return HomePageCard(
                          onPress: () {
                            op.setSubTitle('عمليات الوارد الشهري');
                            op.getMonthlySubOP('وارد');
                            Get.to(const ShowSubOperation());
                          },
                          backgroundColor: Colors.green,
                          icon: Icons.arrow_downward_outlined,
                          mainText: '${op.monthlyWard}',
                          unitText: ' (لتر)  ',
                          subText: 'الوارد الشهري',
                          textColor: Colors.white,
                          iconColor: Colors.green[700],
                        );
                      }),
                      SizedBox(
                        width: 20.w,
                      ),
                      Consumer<DbProvider>(builder: (context, dbPro, x) {
                        return HomePageCard(
                          onPress: () => Get.to(const ShowSubconsumer()),
                          backgroundColor: Colors.red,
                          icon: Icons.people_rounded,
                          mainText: '${dbPro.numOfSub}',
                          unitText: ' (مستهلك)  ',
                          subText: 'عدد المستهلكين',
                          textColor: Colors.white,
                          iconColor: Colors.red[700],
                        );
                      }),
                    ],
                  );
                }),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Consumer<OpProvider>(builder: (context, op, x) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomePageCard(
                        onPress: () {
                          op.setSubTitle('عمليات الصرف');
                          op.getTotalSubOP('صرف');
                          Get.to(const ShowSubOperation());
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.arrow_upward,
                        mainText: '${op.totalSarf}',
                        unitText: ' (لتر)  ',
                        subText: 'إجمالي المصروف',
                        textColor: Colors.white,
                        iconColor: Colors.red[700],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      HomePageCard(
                        onPress: () {
                          op.setSubTitle('عمليات الصرف الشهري');
                          op.getMonthlySubOP('صرف');
                          Get.to(const ShowSubOperation());
                        },
                        backgroundColor: Colors.green,
                        icon: Icons.arrow_upward,
                        mainText: '${op.monthlySarf ?? 0}',
                        unitText: ' (لتر)  ',
                        subText: 'الصرف الشهري',
                        textColor: Colors.white,
                        iconColor: Colors.green[700],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      HomePageCard(
                        onPress: () {
                          op.setSubTitle('عمليات الصرف الاسبوعي');
                          op.getWeeklySubOP();
                          Get.to(const ShowSubOperation());
                        },
                        backgroundColor: Colors.yellow,
                        icon: Icons.arrow_upward,
                        mainText: '${op.weeklySarf ?? 0}',
                        unitText: ' (لتر)  ',
                        subText: 'الصرف الاسبوعي',
                        textColor: Colors.black,
                        iconColor: Colors.yellow[700],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      HomePageCard(
                        onPress: () async {
                          op.setSubTitle('عمليات الصرف اليومي');
                          op.getDailySubOP();
                          Get.to(const ShowSubOperation());
                        },
                        backgroundColor: Colors.cyan,
                        icon: Icons.arrow_upward,
                        mainText: '${op.dailySarf ?? 0}',
                        unitText: ' (لتر)  ',
                        subText: 'الصرف اليومي',
                        textColor: Colors.white,
                        iconColor: Colors.cyan[700],
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                        ),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text('اخر العمليات'),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 1.2.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: Card(
                          shape: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          elevation: 5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Consumer<OpProvider>(
                                    builder: (context, provider, x) {
                                  return OperationTable(
                                      operations: provider.lastTenOp ?? []);
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
