import 'package:flutter/material.dart';
import 'package:geo_location/presentation/screens/geolocation_funct_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
   @override
  Widget build(BuildContext context) {
   return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorSchemeSeed: Colors.green
    ),
    home: const GeolocationFunctionsScreen()
   );
  }
}
