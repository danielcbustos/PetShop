import 'package:flutter/material.dart';
import 'package:frontend/models/product_model.dart';
import 'package:frontend/models/reservation_model.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/services/reservation_service.dart';
import 'package:frontend/utils/responsive/Adapt.dart';
import 'package:frontend/widgets/header.dart';
import 'package:frontend/widgets/log_out.dart';
import 'package:go_router/go_router.dart';

class ReservationList extends StatefulWidget {
  const ReservationList({super.key});

  @override
  State<ReservationList> createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  ReservationService reservationService = ReservationService();
  List<Reservation>? data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.redAccent,
          ),
          onPressed: () => context.go('/reservations'),
        ),
        actions: [logOut(context, Colors.redAccent)],
      ),
      body: Container(
        padding: EdgeInsets.all(Adapt.px(10)),
        child: FutureBuilder(
            future: reservationService.getReservation(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return Column(
                children: [
                  header('Mis Reservas', context),
                  if (snapshot.connectionState == ConnectionState.waiting)
                    Center(child: CircularProgressIndicator()),
                  if (snapshot.hasData)
                    Expanded(
                      child: ItemList(
                        list: snapshot.data as List<Reservation>,
                      ),
                    ),
                  if (!snapshot.hasData && !snapshot.hasError)
                    Center(child: Text('Cargando')),
                  if (snapshot.hasError)
                    Center(child: Text('Error: ${snapshot.error}')),
                ],
              );
            }),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<Reservation>? list;
  ReservationService reservationService = ReservationService();
  ItemList({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list?.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                      title: Text(list![i].reservationDate.toString(),
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.black)),
                      subtitle: Text(list![i].description.toString()),
                      leading: Icon(Icons.pets),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.redAccent),
                              fixedSize: MaterialStateProperty.all<Size>(
                                Size(100, 25),
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Confirmar"),
                                    content: Text(
                                        "¿Estás seguro de que deseas cancelar esta reserva?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Cerrar el diálogo
                                        },
                                        child: Text("Cancelar"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          try {
                                            await reservationService
                                                .deleteReservation(list![i].id);
                                            Navigator.of(context)
                                                .pop(); // Cerrar el diálogo
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Reserva cancelada exitosamente'),
                                              backgroundColor: Colors.green,
                                            ));
                                            context.go('/reservations');
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Error al cancelar la reserva: $e'),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        },
                                        child: Text("Confirmar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Cancelar'))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
