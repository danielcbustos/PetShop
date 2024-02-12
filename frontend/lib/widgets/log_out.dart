import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget logOut(BuildContext context, Color iconColor) {
  return IconButton(
      color: iconColor,
      onPressed: () {
        context.go('/');
      },
      icon: const Icon(Icons.person));
}
