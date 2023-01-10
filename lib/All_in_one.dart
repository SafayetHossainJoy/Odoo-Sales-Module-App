import 'package:flutter/material.dart';
import 'package:sales_app/Responsive/responsive.dart';
import 'package:sales_app/Screen/splash_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: const splash_screen(),
      ),
    );
  }
}
