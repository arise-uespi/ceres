import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uespi_reserva/provider/auth_provider.dart';
import 'package:uespi_reserva/provider/controller_provider.dart';
import 'package:uespi_reserva/util/name_routes.dart';
import 'package:uespi_reserva/views/auth_home_view.dart';
import 'package:uespi_reserva/views/home_view.dart';
import 'package:uespi_reserva/views/login_view.dart';
import 'package:uespi_reserva/views/resource_view.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ControllerProvider>(
          create: (context) => ControllerProvider(),
          update: (context, auth, prod) {
            return ControllerProvider(token: auth.token);
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthHomeView(),
        routes: {
          Routes.LOGIN_VIEW: (ctx) => LoginView(),
          Routes.HOME_VIEW: (ctx) => HomeView(),
          Routes.RESOURCES_VIEW: (ctx) => ResourceView(),
        },
      ),
    );
  }
}
