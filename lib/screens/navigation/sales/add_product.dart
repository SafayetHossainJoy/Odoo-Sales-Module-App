import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sales_app/screens/navigation/sales/sales_page.dart';
import 'package:sales_app/widgets/band_color.dart';
import 'package:sales_app/widgets/custom_textfor_customer.dart';
import 'package:sales_app/widgets/widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController customernameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController pricelistController = TextEditingController();
  TextEditingController globaldiscountController = TextEditingController();
  TextEditingController termsandconditionsController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // idController = TextEditingController();
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

    request.fields['name'] = nameController.text.toString();
    request.fields['description'] = descriptionController.toString();
    request.fields['quantity'] = quantityController.text.toString();
    request.fields['original_price'] = uomController.text.toString();
    request.fields['discounted_price'] = unitPriceController.text.toString();
    request.fields['percent_of'] = percentOfController.text.toString();
    request.fields['fixed_value'] = fixedValueController.text.toString();

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
        title: const Text("Create New Sales Order"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        //padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CustomTextFieldforcustomer(
                  lebelText: 'Customer Name',
                  hintText: 'Enter your Customer name',
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "*Customername required";
                    }
                    if (value.length < 3) {
                      return "*Customername is too short,write minimum 3 letter";
                    } else if (value.length > 20) {
                      return "*Customer name is long";
                    }
                  },
                  validatorFn: (value) {},
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Create Date',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CustomTextFieldforcustomer(
                  lebelText: 'Date',
                  hintText: 'Enter your date',
                  controller: dateController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "*date required";
                    }
                  },
                  validatorFn: (value) {},
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Price List',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CustomTextFieldforcustomer(
                  lebelText: 'Price List',
                  hintText: 'Enter your Price',
                  controller: pricelistController,
                  keytype: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "*Price List required";
                    }
                  },
                  validatorFn: (value) {},
                ),
                /*const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Color.fromARGB(255, 63, 162, 243),
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
                              'Add Product',
                              style: TextStyle(
                                  color: aPrimaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Product Name',
                ),

                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nameController,
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

                /*Text(
                  'Category',
                ),

                SizedBox(
                  height: 10,
                ),
               TextFormField(
                  controller: idController,
                  onSaved: (name) {
                    fildId = name;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Write Product Id";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          gapPadding: 5.0,
                          borderSide:
                          BorderSide(color: aTextColor, width: 2.5)),
                      hintText: 'Enter Product Id'),
                ),*/

                //////
                /* Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  decoration: BoxDecoration(
                      color: aSearchFieldColor,
                      border: Border.all(color: Colors.grey, width: 0.2),
                      borderRadius: BorderRadius.circular(10.0)),
                  height: 60,
                  child: Center(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      decoration: InputDecoration.collapsed(hintText: ''),
                      value: categoryType,
                      hint: Text(
                        'Select Category',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: aTextColor, fontSize: 16),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          categoryType = newValue;
                          print("my Category is $categoryType");
                          if (categoryType!.isEmpty) {
                            showInToast("Category Type required");
                          }
                          // print();
                        });
                      },
                      validator: (value) =>
                          value == null ? 'field required' : null,
                      items: categoryList?.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(
                                "${item['name']}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: aTextColor,
                                    fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              value: item['id'].toString(),
                            );
                          }).toList() ??
                          [],
                    ),
                  ),
                ),
*/
                ///////
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

                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Discount Type:Fixed',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      // const SizedBox(
                      //   width: 135,
                      // ),
                      // const Text(
                      //   'Terms and Conditions',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w700,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomTextFieldforcustomer(
                        lebelText: 'Discount',
                        hintText: 'Global Discount',
                        controller: globaldiscountController,
                        keytype: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "*Discount required";
                          }
                        },
                        validatorFn: (value) {},
                      ),
                    ),
                    // const SizedBox(
                    //   width: 5,
                    // ),
                    Expanded(
                        flex: 5,
                        child: CustomTextFieldforcustomer(
                          lebelText: 'Terms and Conditions',
                          hintText: 'Terms and Conditions....',
                          controller: termsandconditionsController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "*termsandconditions required";
                            }
                          },
                          validatorFn: (value) {},
                        )),
                  ],
                ),

                /*
                Text(
                  'Product Image',
                ),

                SizedBox(
                  height: 10,
                ),
                //image Upload design
                Container(
                  height: height * 0.3,
                  width: weidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: image == null
                      ? InkWell(
                          onTap: () {
                            getImageformGallery();
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: aTextColor.withOpacity(0.3),
                                  size: 40,
                                ),
                                Text(
                                  "UPLOAD",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: aTextColor.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(image!),
                          )),
                        ),
                ),
                //image Upload design

                SizedBox(
                  height: 25,
                ),
                Center(
                    child: Text(
                  '* 320x320 is the Recommended Size',
                  style: TextStyle(
                      color: Colors.black26,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                )),
*/
                const SizedBox(
                  height: 45,
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text('Amount Without Discount:'),
                          const Spacer(),
                          const Text('100.00')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text('Untaxed Amount:'),
                          const Spacer(),
                          const Text('100.00')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text('Fixed Discount:'),
                          Spacer(),
                          Text('0.00')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text('Total Discount:'),
                          Spacer(),
                          Text('0.00')
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 5,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '100.00 ৳',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                //Add Product Button
                const SizedBox(
                  height: 25,
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
                          'Confirm',
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
