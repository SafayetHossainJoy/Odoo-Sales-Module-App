import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/Sales%20pages/sales_page.dart';
import 'package:sales_app/widgets/band_color.dart';
import 'package:sales_app/widgets/custom_textfor_customer.dart';
import 'package:sales_app/widgets/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController productnameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();

  TextEditingController percentOfController = TextEditingController();
  TextEditingController fixedValueController = TextEditingController();

  String? fildName,
      fildId,
      fildQuantity,
      fildOriginalPrice,
      fildDiscountedPrice,
      fildDiscountType,
      fildPercentOf,
      fildFixedValue;
  //String? fildName,fildDiscountType,fildPercentOf;
  //int? fildId,fildQuantity,fildOriginalPrice,fildDiscountedPrice,fildFixedValue;
  bool onProgress = false;
  bool isVisiable = false;
  bool isImageVisiable = false;

  File? image;
  final picker = ImagePicker();

///////
  String? categoryType;

  List? categoryList;

  // Future<dynamic> getCategory() async {
  //   setState(() {
  //     onProgress = true;
  //   });
  //   await CustomHttpRequest.getCategoriesDropDown().then((responce) {
  //     var dataa = json.decode(responce.body);
  //     setState(() {
  //       categoryList = dataa;
  //       onProgress = false;
  //       print("all categories are : $categoryList");
  //     });
  //   });
  // }
  /////

  Future getImageformGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('image found');
        print('$image');
        setState(() {
          isImageVisiable = true;
        });
      } else {
        print('no image found');
      }
    });
  }

  Future createProduct() async {
    setState(() {
      onProgress = true;
    });

    final uri =
        Uri.parse("https://apihomechef.antopolis.xyz/api/admin/product/store");
    var request = http.MultipartRequest("POST", uri);

    // request.headers.addAll(
    //   await CustomHttpRequest().getHeaderWithToken(),
    // );

    // request.fields['name'] = productnameController.text.toString();
    // request.fields['description'] = descriptionController.toString();
    // request.fields['quantity'] = quantityController.text.toString();
    // request.fields['original_price'] = uomController.text.toString();
    // request.fields['discounted_price'] = unitPriceController.text.toString();
    // request.fields['percent_of'] = percentOfController.text.toString();
    // request.fields['fixed_value'] = fixedValueController.text.toString();

    //for image
    if (image != null) {
      var photo = await http.MultipartFile.fromPath('image', image!.path);
      print('processing');
      request.files.add(photo);
    }

    //for icon
    /*if (icon != null) {
      var _icon = await http.MultipartFile.fromPath('icon', icon!.path);
      print('processing');
      request.files.add(_icon);
    }*/

    var response = await request.send();
    print("${response.statusCode}");

    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var data = jsonDecode(responseString);
    if (response.statusCode == 201) {
      print("responseBody1 $responseData");

      print('oooooooooooooooooooo');
      print(data['message']);
      setState(() {
        onProgress = false;
      });
      showInToast(data['message']);
      Navigator.pop(context);
      print("***************");
      print("${response.statusCode}");
    } else {
      print('else call');
      print("responseBody1 $responseString");
      print(data['errors']['image'][0]);
      showInToast(data["errors"]['image'][0]);
      setState(() {
        onProgress = false;
      });
    }
  }

  @override
  void initState() {
    //getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double weidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Color.fromARGB(193, 255, 82, 82)),
        leading: InkWell(
            onTap: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const sales(),
                  ));
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        title: const Text("Create Order Lines"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        //padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Product Name',
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: productnameController,
                  onSaved: (name) {
                    fildName = name;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Write Product Name";
                    }
                    if (value.length < 3) {
                      return "*Write more then three word";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 5.0,
                          borderSide:
                              const BorderSide(color: aTextColor, width: 2.5)),
                      hintText: 'Enter Product Name'),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // const addmore(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Description',
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: descriptionController,
                  onSaved: (description) {
                    fildName = description;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Write Description";
                    }
                    if (value.length < 3) {
                      return "*Write more then three word";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 5.0,
                          borderSide:
                              const BorderSide(color: aTextColor, width: 2.5)),
                      hintText: 'Enter Product Description'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Quantity',
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: quantityController,
                  onSaved: (name) {
                    fildQuantity = name;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Write Product Quantity";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 5.0,
                          borderSide:
                              const BorderSide(color: aTextColor, width: 2.5)),
                      hintText: 'Enter Product Quantity'),
                ),
                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Unit of Measure',
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: uomController,
                  onSaved: (uom) {
                    fildOriginalPrice = uom;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Write Unit of Measure";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 5.0,
                          borderSide:
                              const BorderSide(color: aTextColor, width: 2.5)),
                      hintText: 'Enter Unit of Measure'),
                ),
                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Unit Price',
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: unitPriceController,
                  onSaved: (name) {
                    fildDiscountedPrice = name;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Write Unit Price";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 5.0,
                          borderSide:
                              const BorderSide(color: aTextColor, width: 2.5)),
                      hintText: 'Enter Unit Price'),
                ),
                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Discount %',
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: percentOfController,
                  onSaved: (name) {
                    fildPercentOf = name;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Write Percent Off";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 5.0,
                          borderSide:
                              const BorderSide(color: aTextColor, width: 2.5)),
                      hintText: 'Enter How Many Percent Off'),
                ),
                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Subtotal',
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: fixedValueController,
                  onSaved: (name) {
                    fildFixedValue = name;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Write Subtotal";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 5.0,
                          borderSide:
                              const BorderSide(color: aTextColor, width: 2.5)),
                      hintText: 'Enter Subtotal'),
                ),

                //Add Product Button
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Colors.black,
                      border: Border.all(color: aTextColor, width: 0.5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   _formKey.currentState!.save();
                        //   if (image == null) {
                        //     showInToast(
                        //         'Please upload Product image from your mobile');
                        //   } else {
                        //     createProduct();
                        //   }
                        // }
                      },
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: aPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                //Add Sales order Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
