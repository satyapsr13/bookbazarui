import '/constants/colors.dart';
import '/pages/welcome_page.dart';
import 'package:flutter/material.dart';

AppBar appbar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: MyColors.primaryColor,
    actions: [
      // s,
      IconButton(
        icon: const Icon(Icons.power_off),
        tooltip: 'logout',
        onPressed: () {
          Navigator.of(context).pushNamed(
            WelComePage.routeName,
            // arguments: product.id
          );
        },
      ),
    ],
  );
}