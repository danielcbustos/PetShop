import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget homeButton(String text, BuildContext context, String route) {
  return ElevatedButton(
    onPressed: () => context.go(route),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
      fixedSize: MaterialStateProperty.all<Size>(
        Size(290, 50),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ), //
      elevation: MaterialStateProperty.all<double>(5),
      shadowColor: MaterialStateProperty.all<Color>(Colors.black),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 25),
    ),
  );
}
