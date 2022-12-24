import 'package:flutter/material.dart';
import 'package:sales_app/screens/navigation/setting/pages/AboutUs.dart';
import 'package:sales_app/screens/navigation/setting/pages/ContactUs.dart';
import 'package:sales_app/screens/navigation/setting/pages/Privacy_Policy.dart';
import 'package:sales_app/screens/navigation/setting/pages/Feedback.dart';
import 'package:sales_app/screens/splash_screen.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 202, 65, 65),
        elevation: 10,
        centerTitle: true,
        leading: InkWell(
            child: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 202, 65, 65),
            ),
            onTap: () {}),
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 10),
          // color: HexColor("#31343E"),
          // color: Colors.white,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.asset(
                  "images/Trivozlogo.jpg",
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              RichText(
                text: const TextSpan(children: [
                  TextSpan(
                      text: "Sales Departments\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                          color: Color.fromARGB(221, 112, 94, 94))),
                  TextSpan(
                      text: "sales@gmail.com",
                      style: TextStyle(
                          fontFamily: 'Montserrat', color: Colors.black54)),
                ]),
              ),
            ],
          ),
        ),
        const Divider(
            height: 1,
            thickness: 0.5,
            color: Color.fromARGB(255, 147, 148, 148)),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          // color: Colors.white,
          child: Column(
            children: <Widget>[
              ListTile(
                dense: true,
                title: const Text(
                  "About Us",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                leading: const Icon(Icons.info),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const About_Us(),
                      ));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                dense: true,
                title: const Text("Contact Us",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                leading: const Icon(Icons.support_agent),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contact_Us(),
                      ));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                title: const Text(
                  "Privacy & policy",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                leading: const Icon(Icons.lock),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Privacy(),
                      ));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                dense: true,
                title: const Text(
                  "FeedBack",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                leading: const Icon(Icons.assistant),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Review(),
                      ));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                  leading: const Icon(Icons.power_settings_new),
                  title: new Text(
                    "Logout",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const splash_screen(),
                        ));
                  }),
            ],
          ),
        ),
      ])),
    );
  }
}
