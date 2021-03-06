// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_single_cascade_in_expression_statements, unused_local_variable, library_prefixes, avoid_print

import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bookbazar/models/book_model.dart';
import 'package:bookbazar/pages/welcome_page.dart';
import 'package:bookbazar/screens/home_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../network_crud_operation.dart';
import '/constants/colors.dart';
import 'package:flutter/material.dart';

class BookSellingFormScreen extends StatefulWidget {
  const BookSellingFormScreen({Key? key}) : super(key: key);
  static const routeName = '/booksellingformscreen';

  @override
  State<BookSellingFormScreen> createState() => _BookSellingFormScreenState();
}

class _BookSellingFormScreenState extends State<BookSellingFormScreen> {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final authorController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final productLocationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  NetworkHandler networkHandler = NetworkHandler();
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: isloading ? Text('Loading...') : Text('Fill your details'),
      ),
      body: googleuser.id == ""
          ? WelComePage()
          : isloading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title', style: textstyle(context)),
                          titletextwidget(mediaQuery),
                          const Sizedbox(),
                          Text('Subtitle', style: textstyle(context)),
                          subtitletextwidget(mediaQuery),
                          const Sizedbox(),
                          Text('Author', style: textstyle(context)),
                          authortextwidget(mediaQuery),
                          const Sizedbox(),
                          Text('Description', style: textstyle(context)),
                          descriptiontextwidget(mediaQuery),
                          const Sizedbox(),
                          Text('Address', style: textstyle(context)),
                          addresswidget(mediaQuery),
                          const Sizedbox(),
                          price(context, mediaQuery),
                          const Sizedbox(),
                          submit(mediaQuery, context)
                        ],
                      ),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isloading = false;
          });
        },
      ),
    );
  }

  AwesomeDialog WelComePageRedirectDialogue(BuildContext context) {
    return AwesomeDialog(
      context: context, showCloseIcon: true,
      dialogType: DialogType.INFO_REVERSED,
      animType: AnimType.BOTTOMSLIDE, //awesome_dialog: ^2.1.1
      title: 'Not Login?',
      // desc: 'Dialog description here.............',
      // btnCancelOnPress: () {},
      btnOkText: 'Login',
      btnOkColor: Theme.of(context).primaryColor,
      btnOkOnPress: () {},
    );
  }

  TextFormField authortextwidget(Size mediaQuery) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter author name';
        }
        return null;
      },
      controller: authorController,
      decoration: inputDecorations("author", mediaQuery),
    );
  }

  TextFormField subtitletextwidget(Size mediaQuery) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter Subtitle';
        }
        return null;
      },
      controller: subtitleController,
      decoration: inputDecorations("subtitle", mediaQuery),
    );
  }

  TextFormField titletextwidget(Size mediaQuery) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter title';
        }
        return null;
      },
      controller: titleController,
      decoration: inputDecorations("Title", mediaQuery),
    );
  }

  TextFormField descriptiontextwidget(Size mediaQuery) {
    return TextFormField(
      controller: descriptionController,
      decoration: inputDecorations("Description", mediaQuery),
      maxLines: 3,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter description';
        }
        return null;
      },
    );
  }

  TextFormField addresswidget(Size mediaQuery) {
    return TextFormField(
      controller: addressController,
      decoration: inputDecorations("address", mediaQuery),
      maxLines: 3,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter address';
        }
        return null;
      },
    );
  }

  Center submit(Size mediaQuery, BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: mediaQuery.width * 0.35,
            height: 40,
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
                child: const Text('Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                style: buttonStyle(context),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isloading = true;
                    });

                    AwesomeDialog(
                      context: context, dialogType: DialogType.QUESTION,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'All book  details are correct ?',
                      // desc: 'Dialog description here.............',
                      btnCancelOnPress: () {
                        setState(() {
                          isloading = false;
                        });
                      },
                      btnOkOnPress: () async {
                        BookModel bookdata = BookModel(
                            title: titleController.text,
                            id: googleuser.id.toString(),
                            description: descriptionController.text,
                            subtitle: subtitleController.text,
                            author: authorController.text,
                            bookImageUrl: authorController.text,
                            price: priceController.text,
                            address: addressController.text);
                        var response =
                            await networkHandler.post1("/book/add", bookdata);
                        setState(() {
                          isloading = false;
                        });

                        if (response.statusCode == 200 ||
                            response.statusCode == 201) {
                          // String id = json.decode(response.body)["data"];
                          // // var imageResponse = await networkHandler.patchImage(
                          // //     "/blogpost/add/coverImage/$id", _imageFile.path);
                          // print(imageResponse.statusCode);
                          // if (imageResponse.statusCode == 200 ||
                          //     imageResponse.statusCode == 201) {
                          //   Navigator.pushAndRemoveUntil(
                          //       context,
                          //       MaterialPageRoute(builder: (context) => HomePage()),
                          //       (route) => false);
                          // }
                          successDialogue(context);
                        } else {
                          errorDailogue(context);
                        }
                      },
                    )..show();
                  }
                }),
          ),
          SizedBox(height: mediaQuery.height * 0.05),
        ],
      ),
    );
  }

  AwesomeDialog errorDailogue(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.TOPSLIDE,
      title: 'Please try again',
      // desc: 'Dialog description here.............',
      // btnCancelOnPress: () {},
      btnOkText: "OK",
      btnOkOnPress: () {},
    )..show();
  }

  AwesomeDialog successDialogue(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Success',
      // desc: 'Dialog description here.............',
      // btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.pop(context);
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    )..show();
  }

  Row price(BuildContext context, Size mediaQuery) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price', style: textstyle(context)),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: TextFormField(
                validator: (value) {
                  RegExp numeric = RegExp(r"(\w+)");
                  if (value!.isEmpty) {
                    return 'Please enter price';
                  }
                  const pattern = r'[0-9]';
                  final regExp = RegExp(pattern);

                  if (!regExp.hasMatch(value)) {
                    return "Price should be number only";
                  }

                  return null;
                },
                controller: priceController,
                decoration: inputDecorations("Price", mediaQuery),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Location',
              style: textstyle(context),
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
                decoration: inputDecorations("Product Location", mediaQuery),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget submitButton() {
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

  InputDecoration inputDecorations(String d, Size mediaquery) {
    return InputDecoration(
        hintText: d,
        hintStyle: TextStyle(fontSize: mediaquery.width * 0.04),
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
      borderSide: BorderSide(color: MyColors.primaryColor, width: 2),
    );
  }

  OutlineInputBorder outlineBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.primaryColor));
  }

  TextStyle textstyle(BuildContext context) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.bold);
  }
}

class Sizedbox extends StatelessWidget {
  const Sizedbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}
