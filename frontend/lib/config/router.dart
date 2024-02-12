import 'package:flutter/material.dart';
import 'package:frontend/pages/home.dart';
import 'package:frontend/pages/login.dart';
import 'package:frontend/pages/register.dart';
import 'package:frontend/pages/reservation/reservation_create.dart';
import 'package:frontend/pages/reservation/reservation_list.dart';
import 'package:frontend/pages/reservation/reservation_main.dart';
import 'package:frontend/pages/shop/product_list.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Login();
      }),
  GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return Register();
      }),
  GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return MyHomePage();
      }),
  GoRoute(
      path: '/products',
      builder: (BuildContext context, GoRouterState state) {
        return ProductList();
      }),
  GoRoute(
      path: '/reservations',
      builder: (BuildContext context, GoRouterState state) {
        return ReservationMain();
      }),
  GoRoute(
      path: '/reservationList',
      builder: (BuildContext context, GoRouterState state) {
        return ReservationList();
      }),
  GoRoute(
      path: '/createReservation',
      builder: (BuildContext context, GoRouterState state) {
        return CreateReservation();
      }),
]);
