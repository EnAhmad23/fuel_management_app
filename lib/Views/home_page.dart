import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuel_management_app/Views/Widgets/home_page_card.dart';
import 'package:fuel_management_app/Views/Widgets/operationTable.dart';
import 'package:fuel_management_app/Views/add.dart';
import 'package:fuel_management_app/Views/add_subconsumer.dart';
import 'package:fuel_management_app/Views/showConsumers.dart';
import 'package:fuel_management_app/Views/show_subconsumer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShowConsumers(),
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
                  ),
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
                    leading:
                        const Icon(Icons.person_add_alt_1, color: Colors.white),
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
                  ListTile(
                    onTap: () {
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
                  ),
                  ListTile(
                    onTap: () {
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
                    leading:
                        const Icon(Icons.person_add_alt_1, color: Colors.white),
                  ),
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
                  ListTile(
                    title: Text(
                      'عرض',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                    leading: const Icon(Icons.remove_red_eye_outlined,
                        color: Colors.white),
                  ),
                  ExpansionTile(
                    title: Text(
                      'إضافة',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                    leading:
                        const Icon(Icons.add_box_outlined, color: Colors.white),
                    children: [
                      ListTile(
                        title: Text('صرف',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white)),
                        leading:
                            const Icon(Icons.arrow_upward, color: Colors.white),
                      ),
                      ListTile(
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
              ListTile(
                title: Text('بحث',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white)),
                leading: const Icon(Icons.search_rounded, color: Colors.white),
              ),
            ],
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomePageCard(
                      backgroundColor: Colors.yellow,
                      icon: Icons.window,
                      mainText: '500         vdfv',
                      subText: '300',
                      textColor: Colors.black,
                      iconColor: Colors.yellow[700],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    HomePageCard(
                      backgroundColor: Colors.cyan,
                      icon: Icons.arrow_downward_outlined,
                      mainText: '500         vdfv',
                      subText: '300',
                      textColor: Colors.white,
                      iconColor: Colors.cyan[700],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    HomePageCard(
                      backgroundColor: Colors.green,
                      icon: Icons.arrow_downward_outlined,
                      mainText: '500         vdfv',
                      subText: '300',
                      textColor: Colors.white,
                      iconColor: Colors.green[700],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    HomePageCard(
                      backgroundColor: Colors.red,
                      icon: Icons.people_rounded,
                      mainText: '500         vdfv',
                      subText: '300',
                      textColor: Colors.white,
                      iconColor: Colors.red[700],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HomePageCard(
                      backgroundColor: Colors.red,
                      icon: Icons.arrow_upward,
                      mainText: '500         vdfv',
                      subText: '300',
                      textColor: Colors.white,
                      iconColor: Colors.red[700],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    HomePageCard(
                      backgroundColor: Colors.green,
                      icon: Icons.arrow_upward,
                      mainText: '500         vdfv',
                      subText: '300',
                      textColor: Colors.white,
                      iconColor: Colors.green[700],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    HomePageCard(
                      backgroundColor: Colors.yellow,
                      icon: Icons.arrow_upward,
                      mainText: '500         vdfv',
                      subText: '300',
                      textColor: Colors.black,
                      iconColor: Colors.yellow[700],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    HomePageCard(
                      backgroundColor: Colors.cyan,
                      icon: Icons.arrow_upward,
                      mainText: '500         vdfv',
                      subText: '300',
                      textColor: Colors.white,
                      iconColor: Colors.cyan[700],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text('اخر العمليات'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: const Card(
                          shape: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          elevation: 5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                OperationTable(operations: []),
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
