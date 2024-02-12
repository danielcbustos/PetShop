import 'package:flutter/material.dart';

import 'package:frontend/pages/home.dart';
import 'package:frontend/pages/shop/product_list.dart';
import 'package:frontend/config/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Peluditos App',
      routerConfig: router,
    );
  }
}
