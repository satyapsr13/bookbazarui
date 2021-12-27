// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:bookbazar/constants/colors.dart';
import 'package:flutter/material.dart';

class BookSellingFormScreen extends StatefulWidget {
  const BookSellingFormScreen({Key? key}) : super(key: key);
  static const routeName = '/booksellingformscreen';

  @override
  State<BookSellingFormScreen> createState() => _BookSellingFormScreenState();
}

class _BookSellingFormScreenState extends State<BookSellingFormScreen> {
  final titleController = TextEditingController();
  final discriptionController = TextEditingController();
  final priceController = TextEditingController();
  final productLocationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text('Fill your details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: h1Textstyle(context)),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Title';
                    }
                    return null;
                  },
                  controller: titleController,
                  decoration: inputDecorations("Title"),
                ),
                SizedBox(
                  height: 30,
                ),
                FittedBox(
                  child: Text('Description', style: h1Textstyle(context)),
                ),
                TextFormField(
                  controller: discriptionController,
                  decoration: inputDecorations("Description"),
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price', style: h1Textstyle(context)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter price';
                              }
                              return null;
                            },
                            controller: priceController,
                            decoration: inputDecorations("Price"),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product Location',
                          style: h1Textstyle(context),
                        ),
                        Container(
                          width: mediaQuery.width * 0.45,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter location';
                              }
                              return null;
                            },
                            controller: productLocationController,
                            decoration: inputDecorations("Product Location"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    // width: double.infinity,
                    width: mediaQuery.width * 0.5,
                    height: 50,
                    child: TextButton(
                        child: Text('Submit',
                            style: const TextStyle(fontSize: 16)),
                        style: buttonStyle(context),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      //floatingActionButton: FloatingActionButton(onPressed: (){},),
    );
  }

  Widget addButton() {
    return InkWell(
      onTap: () async {
        // if (_imageFile != null && _globalkey.currentState.validate()) {
        //   AddBlogModel addBlogModel =
        //       AddBlogModel(body: _body.text, title: _title.text);
        //   var response = await networkHandler.post1(
        //       "/blogpost/Add", addBlogModel.toJson());
        //   print(response.body);

        //   if (response.statusCode == 200 || response.statusCode == 201) {
        //     String id = json.decode(response.body)["data"];
        //     var imageResponse = await networkHandler.patchImage(
        //         "/blogpost/add/coverImage/$id", _imageFile.path);
        //     print(imageResponse.statusCode);
        //     if (imageResponse.statusCode == 200 ||
        //         imageResponse.statusCode == 201) {
        //       Navigator.pushAndRemoveUntil(
        //           context,
        //           MaterialPageRoute(builder: (context) => HomePage()),
        //           (route) => false);
        //     }
        // }
        // }
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.teal),
          child: Center(
              child: Text(
            "Add Blog",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  ButtonStyle buttonStyle(BuildContext context) {
    return ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
        // foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).errorColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  width: 3,
                  color: MyColors.primaryColor,
                ))));
  }

  InputDecoration inputDecorations(String d) {
    return InputDecoration(
        hintText: d,
        border: outlineBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: focusedBorder());
  }

  OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: MyColors.primaryColor),
    );
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.primaryColor));
  }

  TextStyle h1Textstyle(BuildContext context) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.039,
        fontWeight: FontWeight.bold);
  }
}
