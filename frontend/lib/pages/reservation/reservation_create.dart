import 'package:flutter/material.dart';
import 'package:frontend/services/reservation_service.dart';
import 'package:go_router/go_router.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:frontend/widgets/log_out.dart';

class CreateReservation extends StatefulWidget {
  const CreateReservation({super.key});

  @override
  State<CreateReservation> createState() => _CreateReservationState();
}

class _CreateReservationState extends State<CreateReservation> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  ReservationService reservationService = ReservationService();
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [logOut(context, Colors.redAccent)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Peluditos\nApp',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  letterSpacing: 5),
            ),
            SizedBox(height: 50),
            Text(
              'Haz tu Reserva',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  letterSpacing: 3),
            ),
            SizedBox(height: 100),
            Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 5),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.redAccent),
                              fixedSize: MaterialStateProperty.all<Size>(
                                Size(290, 50),
                              ),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ), //
                              elevation: MaterialStateProperty.all<double>(5),
                              shadowColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            onPressed: () async {
                              DateTime? dateTime = await showOmniDateTimePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1600)
                                    .subtract(const Duration(days: 3652)),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 3652),
                                ),
                                is24HourMode: false,
                                isShowSeconds: false,
                                minutesInterval: 1,
                                secondsInterval: 1,
                                isForce2Digits: true,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                constraints: const BoxConstraints(
                                  maxWidth: 350,
                                  maxHeight: 650,
                                ),
                                transitionBuilder:
                                    (context, anim1, anim2, child) {
                                  return FadeTransition(
                                    opacity: anim1.drive(
                                      Tween(
                                        begin: 0,
                                        end: 1,
                                      ),
                                    ),
                                    child: child,
                                  );
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 200),
                                barrierDismissible: true,
                                selectableDayPredicate: (dateTime) {
                                  // Disable 25th Feb 2023
                                  if (dateTime == DateTime(2023, 2, 25)) {
                                    return false;
                                  } else {
                                    return true;
                                  }
                                },
                              );
                              setState(() {
                                selectedDateTime = dateTime;
                              });
                            },
                            child: const Text(
                                "Selecciona tu horario de reserva",
                                style: TextStyle(fontSize: 15)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Datos Adicionales",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingresa tu descripcion';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.go('/reservations');
                              },
                              child: const Text(
                                'Cancelar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.redAccent),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(130, 50),
                                ),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ), //
                                elevation: MaterialStateProperty.all<double>(5),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () async {
                                if (selectedDateTime != null &&
                                    _formKey.currentState!.validate()) {
                                  try {
                                    final description =
                                        descriptionController.text;
                                    await reservationService.createReservation(
                                        selectedDateTime!, description);
                                    descriptionController.clear();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content:
                                          Text('Reserva creada exitosamente'),
                                      backgroundColor: Colors.green,
                                    ));
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'No puedes realizar mas reservas para ese día\nNo puedes reservar con mas de un mes de antiipación'),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Selecciona la fecha y pon datos adicionales'),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              child: const Text(
                                'Registrar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.redAccent),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(130, 50),
                                ),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ), //
                                elevation: MaterialStateProperty.all<double>(5),
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
