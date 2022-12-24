import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:sales_app/screens/navigation/delivery_page.dart';
import 'package:sales_app/screens/navigation/invoice.dart';
import 'package:sales_app/screens/navigation/sales/sales_page.dart';
import 'package:sales_app/screens/navigation/setting/setting.dart';

class Navigation_bar extends StatefulWidget {
  const Navigation_bar({super.key});

  @override
  State<Navigation_bar> createState() => _Navigation_barState();
}

class _Navigation_barState extends State<Navigation_bar> {
  List pages = [
    const sales(),
    const Invoice(),
    const Delivery(),
    const Setting()
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: pages[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.shifting,
          onTap: onTap,
          currentIndex: currentIndex,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.insights_outlined,
                  color: Color.fromARGB(255, 5, 241, 13),
                ),
                label: "Sales"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.insert_drive_file_outlined,
                  color: Color.fromARGB(255, 58, 7, 241),
                ),
                label: "Invoice"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.delivery_dining,
                  color: Color.fromARGB(255, 250, 21, 5),
                ),
                label: "Delivery"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 61, 60, 60),
                ),
                label: "Settings")
          ]),
    );
  }
}
