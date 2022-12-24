import 'package:flutter/material.dart';
import 'package:sales_app/model_class/sales_model_class.dart';
import 'package:sales_app/screens/navigation/setting/setting.dart';
import 'package:sales_app/widgets/invoice_widget.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key});

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: (const Color.fromARGB(193, 255, 82, 82)),
        title: const Text("Invoice",
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        actions: [
          InkWell(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.filter_alt_outlined),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Setting(),
                    ));
              }),
        ],
      ),
      body: ListView.builder(
          itemCount: DataModel.items.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: invoice_widget(),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Setting(),
                    ));
              },
            );
          }),
    );
  }
}
