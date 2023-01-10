import 'dart:convert';

SalesOrderUser salesOrderUserFromJson(String str) =>
    SalesOrderUser.fromJson(json.decode(str));

String salesOrderUserToJson(SalesOrderUser data) => json.encode(data.toJson());

class SalesOrderUser {
  SalesOrderUser({
    required this.jsonrpc,
    this.id,
    required this.result,
  });

  String jsonrpc;
  dynamic id;
  Result result;

  factory SalesOrderUser.fromJson(Map<String, dynamic> json) => SalesOrderUser(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    required this.status,
    required this.response,
    required this.message,
  });

  int status;
  List<Response> response;
  String message;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "message": message,
      };
}

class Response {
  Response({
    required this.id,
    required this.name,
    required this.customerName,
    required this.date,
    required this.pricelist,
    required this.orderLine,
    required this.invoiceId,
    required this.deliveryId,
  });

  int id;
  String name;
  String customerName;
  DateTime date;
  String pricelist;
  InvoiceId orderLine;
  InvoiceId invoiceId;
  List<dynamic> deliveryId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        name: json["name"],
        customerName: json["customer_name"],
        date: DateTime.parse(json["date"]),
        pricelist: json["pricelist"],
        orderLine: InvoiceId.fromJson(json["order_line"]),
        invoiceId: InvoiceId.fromJson(json["invoice_id"]),
        deliveryId: List<dynamic>.from(json["delivery_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "customer_name": customerName,
        "date": date.toIso8601String(),
        "pricelist": pricelist,
        "order_line": orderLine.toJson(),
        "invoice_id": invoiceId.toJson(),
        "delivery_id": List<dynamic>.from(deliveryId.map((x) => x)),
      };
}

class InvoiceId {
  InvoiceId({
    required this.orderLine,
  });

  List<List<dynamic>> orderLine;

  factory InvoiceId.fromJson(Map<String, dynamic> json) => InvoiceId(
        orderLine: List<List<dynamic>>.from(
            json["order_line"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "order_line": List<dynamic>.from(
            orderLine.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class OrderLineClass {
  OrderLineClass({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.uom,
    required this.priceUnit,
    required this.subtotal,
  });

  String productId;
  String name;
  int quantity;
  String uom;
  int priceUnit;
  int subtotal;

  factory OrderLineClass.fromJson(Map<String, dynamic> json) => OrderLineClass(
        productId: json["product_id"],
        name: json["name"],
        quantity: json["quantity"],
        uom: json["uom"],
        priceUnit: json["price_unit"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "quantity": quantity,
        "uom": uom,
        "price_unit": priceUnit,
        "subtotal": subtotal,
      };
}
