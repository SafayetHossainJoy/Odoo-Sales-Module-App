import 'package:flutter/material.dart';
import 'package:sales_app/screens/navigation/sales/Add_Product.dart';
import 'package:sales_app/widgets/custom_textfor_customer.dart';

class CreateNewCustomer extends StatefulWidget {
  const CreateNewCustomer({super.key});

  @override
  State<CreateNewCustomer> createState() => _CreateNewCustomerState();
}

class _CreateNewCustomerState extends State<CreateNewCustomer> {
  TextEditingController nameController = TextEditingController();
  TextEditingController taxIdController = TextEditingController();
  TextEditingController jobPositionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: (const Color.fromARGB(193, 255, 82, 82)),
        leading: InkWell(
            onTap: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProduct(),
                  ));
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          "Create New Customer",
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   margin: const EdgeInsets.only(left: 20, top: 20),
            //   child: const Text(
            //     "Create New Customer",
            //     style: TextStyle(
            //         fontSize: 25,
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold),
            //   ),
            // ),
            // const SizedBox(
            //   height: 35,
            // ),
            const Text(
              'Company Name',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextFieldforcustomer(
              lebelText: 'Company Name',
              hintText: 'Enter your company name',
              controller: nameController,
              validator: (value) {
                if (value.isEmpty) {
                  return "*username required";
                }
                if (value.length < 3) {
                  return "*username is too short,write minimum 3 letter";
                } else if (value.length > 20) {
                  return "*user name is long";
                }
              },
              validatorFn: (value) {},
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Company Address',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextFieldforcustomer(
              lebelText: 'Company Address',
              hintText: 'Enter your company address',
              controller: areaController,
              validator: (value) {
                if (value.isEmpty) {
                  return "*username required";
                }
                if (value.length < 5) {
                  return "*username is too short,write minimum 3 letter";
                } else if (value.length > 100) {
                  return "*user name is long";
                }
              },
              validatorFn: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'City',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 135,
                  ),
                  const Text(
                    'Zip-Code',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: CustomTextFieldforcustomer(
                    lebelText: 'City',
                    hintText: 'Enter your city',
                    controller: cityController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "*city required";
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
                      lebelText: 'Zip-code',
                      hintText: 'Enter your Zip',
                      controller: zipController,
                      keytype: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "*zip_code required";
                        }
                      },
                      validatorFn: (value) {},
                    )),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Country',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextFieldforcustomer(
              lebelText: 'Country',
              hintText: 'Enter your country',
              controller: countryController,
              validator: (value) {
                if (value.isEmpty) {
                  return "*country required";
                }
              },
              validatorFn: (value) {},
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Tax ID',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextFieldforcustomer(
              lebelText: 'Tax ID',
              hintText: 'Enter your Tax id',
              controller: taxIdController,
              keytype: TextInputType.phone,
              validator: (value) {
                if (value.isEmpty) {
                  return "*Tax ID required";
                }
              },
              validatorFn: (value) {},
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Job Position',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextFieldforcustomer(
              lebelText: 'Job Position',
              hintText: 'Enter your job position',
              controller: jobPositionController,
              validator: (value) {
                if (value.isEmpty) {
                  return "*Job Position";
                }
              },
              validatorFn: (value) {},
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Mobile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextFieldforcustomer(
              lebelText: 'Mobile',
              hintText: 'Enter your mobile number',
              controller: contactController,
              keytype: TextInputType.phone,
              validator: (value) {
                if (value.isEmpty) {
                  return "*contact number required";
                }
              },
              validatorFn: (value) {},
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextFieldforcustomer(
              lebelText: 'Email',
              hintText: 'Enter your email address',
              controller: emailController,
              keytype: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) {
                  return "*Email is empty";
                }
                if (!value.contains('@')) {
                  return "*wrong email address";
                } else if (!value.contains('.')) {
                  return "*wrong email address";
                }
              },
              validatorFn: (value) {},
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Website Link',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextFieldforcustomer(
              lebelText: 'Website Link',
              hintText: 'Enter your website link',
              controller: websiteController,
              validator: (value) {
                // if (value.isEmpty) {
                //   return "*username required";
                // }
                // if (value.length < 3) {
                //   return "*username is too short,write minimum 3 letter";
                // } else if (value.length > 20) {
                //   return "*user name is long";
                // }
              },
              validatorFn: (value) {},
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Tags',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            CustomTextFieldforcustomer(
              lebelText: 'Tags',
              hintText: 'Enter your Tags',
              controller: tagController,
              validatorFn: (value) {},
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(
                  width: 20, //<-- SEE HERE
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Discard',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
