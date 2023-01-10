import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:sales_app/Navigation%20Bar/navigation_ber.dart';
import 'package:sales_app/widgets/custom_TextField.dart';
import 'package:sales_app/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String loginLink = "https://www.xsellencebdltd.com/web/session/authenticate";

  late SharedPreferences sharedPreferences;

  // check use is login or not if login then goto next page and save user data and one time login
  isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Navigation_bar()));
    } else {
      print("Token is empty");
    }
  }

  getLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var map = Map<String, dynamic>();
    map["email"] = emailController.text.toString();
    map["password"] = passwordController.text.toString();
    var responce = await http.post(
      Uri.parse(loginLink),
      body: map,
    );
    if (responce.statusCode == 200) {
      showInToast("Login Succesfull");
      var data = jsonDecode(responce.body);
      setState(() {
        sharedPreferences.setString("token", data["access_token"]);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Navigation_bar()));
      });
      token = sharedPreferences.getString("token");

      print("token is $token");
    } else {
      showInToast("Invalid Email or Password");
    }
  }

  String? token;

  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              height: 300,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)),
                color: Colors.redAccent,
                gradient: LinearGradient(
                  colors: [
                    (Color.fromARGB(255, 237, 79, 79)),
                    Color.fromARGB(255, 245, 225, 225)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      "assets/images/Trivoz.png",
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20, top: 20),
                    alignment: Alignment.bottomRight,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: emailController,
            hintText: "Enter your Email",
            prefixIcon: const Icon(Icons.email),
            validatorFn: (value) {},
          ),
          CustomTextField(
            controller: passwordController,
            hintText: "Enter your password",
            prefixIcon: const Icon(Icons.vpn_key),
            validatorFn: (value) {},
          ),
          MaterialButton(
            onPressed: () {
              getLogin();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Navigation_bar(),
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Colors.redAccent,
                  Color.fromARGB(255, 250, 236, 236)
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: const Text(
                "LOGIN",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
