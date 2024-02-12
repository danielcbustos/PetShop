import 'package:flutter/material.dart';
import 'package:frontend/utils/responsive/Adapt.dart';
import 'package:go_router/go_router.dart';

Widget header(String title, BuildContext context) {
  return Container(
    // height: size.height * 0.3,
    // width: size.width,
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () => context.go('/home'),
          child: Text(
            'Peluditos',
            style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 50,
                letterSpacing: 5),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              letterSpacing: 3),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
