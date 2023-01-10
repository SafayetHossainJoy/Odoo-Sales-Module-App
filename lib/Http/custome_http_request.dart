import 'dart:convert';

import 'package:sales_app/Model_class/sales_orderlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CustomHttpRequest {
  static const Map<String, String> defaultHeader = {
    "Accept": "application/json",
    "Authorization":
        "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpaG9tZWNoZWYuYW50b3BvbGlzLnh5elwvYXBpXC9hZG1pblwvc2lnbi1pbiIsImlhdCI6MTY1NDAwNzYwNiwiZXhwIjoxNjY2OTY3NjA2LCJuYmYiOjE2NTQwMDc2MDYsImp0aSI6IjlLWGFGNmRFdlgwWVNZVzIiLCJzdWIiOjUwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.Cbii274lgjkMIf2Ix9fZ7e8HPAT47B5MV0QP03Rd520",
  };

  late SharedPreferences sharedPreferences;

  Future<Map<String, String>> getHeaderWithToken() async {
    sharedPreferences = await SharedPreferences.getInstance();

    var header = {
      "Accept": "application/json",
      "Authorization": "bearer ${sharedPreferences.getString("token")}"
    };
    return header;
  }

  getSalesOrderData() async {
    List<SalesOrderUser> orderData = [];
    var responce = await http.get(
        Uri.parse("https://www.xsellencebdltd.com/api/v1/sale_order_user"),
        headers: await CustomHttpRequest().getHeaderWithToken());
    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body);
      print("Order list are $data");
      for (var item in data) {}
    }
    return orderData;
  }
}
