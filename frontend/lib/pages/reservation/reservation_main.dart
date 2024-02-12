import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/responsive/adapt.dart';
import 'package:frontend/widgets/home_button.dart';

class ReservationMain extends StatefulWidget {
  const ReservationMain({super.key});

  @override
  State<ReservationMain> createState() => _ReservationMainState();
}

class _ReservationMainState extends State<ReservationMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () {},
              icon: const Icon(Icons.person))
        ],
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
                'assets/paseo.png',
                fit: BoxFit.cover,
                height: 850,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 120),
                Center(
                  child: Text(
                    '¡Tu amigo esta en\n buenas manos!',
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
                    homeButton('Tus reservas', context, "/reservationList"),
                    SizedBox(
                      height: 25,
                    ),
                    homeButton(
                        '¡Haz tu reserva!', context, "/createReservation"),
                    SizedBox(
                      height: 25,
                    ),
                    homeButton('Regresar', context, "/home")
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
