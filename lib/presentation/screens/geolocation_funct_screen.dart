import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationFunctionsScreen extends StatefulWidget {

  const  GeolocationFunctionsScreen({super.key});

  @override
  State< GeolocationFunctionsScreen> createState() => _GeolocationFunctionsScreenState();
}



class _GeolocationFunctionsScreenState extends State<GeolocationFunctionsScreen> {
  late Future<Position> getPos;
   
  @override
  void initState() {
    super.initState();
    getPos = _determinePosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo localizador'),
        actions: [
          IconButton(
          icon: const Icon(Icons.refresh_rounded), 
          onPressed: () {
            setState(() {
              getPos;
            });
            
            },),
        ],
        
      ),
      body: FutureBuilder<dynamic>(
        future: Future.wait([getPos]),
        builder: (context, snapshot){
          
          if(snapshot.hasData){
            return Column(
              children: [
                Text("ubicacion ${snapshot.data[0]}"),
              ],
            );
          } else if(snapshot.hasError) {
            return Text('${snapshot.hasError}');
          }
          return const CircularProgressIndicator();
        },
        )
      // body: const Center(
      //   child: Column(
      //      mainAxisAlignment: MainAxisAlignment.center,
      //      children: [
      //       Text('hola',  style: TextStyle(fontSize: 160, fontWeight: FontWeight.w100))
      //      ],
      //   )
      //   ),
    );
  }
}


Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;


  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
  
    return Future.error('Location services are disabled.');
  }

  
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
 
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

 
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}


 double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radio de la Tierra en kilómetros

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c; // Distancia en kilómetros
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }



class CustomButton extends StatelessWidget {

  final IconData icon;
  final VoidCallback? onPressed;


  const CustomButton({
    super.key, 
    required this.icon, 
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // shape: const StadiumBorder(),
      enableFeedback: true,
      elevation: 10,
    onPressed: onPressed,
    child: Icon(icon),
    );
  }
}