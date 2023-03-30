import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialRoute: '/',
        routes: {
          '/': (context) => Welcome(),
          // '/login': (context) => LoginScreen(),
          // '/home': (context) => Homepage(),
          // '/signup': (context) => RegistrationScreen(),
          // '/ride_request': (context) => ride_request(
          //     ModalRoute.of(context)!.settings.arguments as Position),
          // '/request_page': (context) => RideRequest(),
          // '/main_screen': (context) => Main_Screen(),
    );
  }
}

