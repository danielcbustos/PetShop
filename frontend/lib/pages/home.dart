import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/responsive/adapt.dart';
import 'package:frontend/widgets/home_button.dart';
import 'package:frontend/widgets/log_out.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [logOut(context, Colors.white)],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Stack(alignment: Alignment.topCenter, children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.02),
                BlendMode.lighten,
              ),
              child: Image.asset(
                'assets/home.jpg',
                fit: BoxFit.cover,
                height: 850,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 120),
                Center(
                  child: Text(
                    '¡Bienvenido a\nPeluditos App!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 240),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homeButton('Tienda de mascotas', context, "/products"),
                    SizedBox(
                      height: 25,
                    ),
                    homeButton('Reserva tu paseo', context, "/reservations")
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
