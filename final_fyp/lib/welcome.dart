// // ignore_for_file: unnecessary_import
// import 'package:google_maps_flutter/google_maps_flutter.dart'
//     show LatLng, BitmapDescriptor, Marker, Location;
// import 'package:google_maps_webservice/places.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // ignore: import_of_legacy_library_into_null_safe
// import 'package:google_maps_webservice/places.dart';
// import 'dart:async';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class Location {
//   final double latitude;
//   final double longitude;

//   Location(this.latitude, this.longitude);
// }

// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   Completer<GoogleMapController> _controller = Completer();
//   TextEditingController _searchController = TextEditingController();
//   LatLng _center = LatLng(37.7749, -122.4194);
//   final _places = GoogleMapsPlaces(apiKey: 'AIzaSyAT8pCVh8o7Q9IoYxBRJ7WJ3ndmw1NZCAk');
//   List<PlacesSearchResult> _placesList = [];

//   Set<Marker> _markers = {};

//   @override


//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search for a place',
//             border: InputBorder.none,
//             suffixIcon: IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 _searchPlace(_searchController.text);
//               },
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 12.0,
//             ),
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.3,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(20),
//                 ),
//               ),
//               child: ListView.builder(
//                 itemCount: _placesList.length,
//                 itemBuilder: (context, index) {
//                   final place = _placesList[index];
//                   return ListTile(
//                     title: Text(place.name),
//                     subtitle: Text(place.formattedAddress),
//                     onTap: () {
//                       _moveCameraToLocation(
//                         place.geometry.location.lat,
//                         place.geometry.location.lng,
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// Future<void> _searchPlace(String query) async {
//     final location1 = Location(_center.latitude, _center.longitude);
//     final result = await _places.searchByText(query, location: location1);

//     if (result.status == 'OK') {
//       setState(() {
//         _placesList = result.results;
//         _markers.clear();
//         for (var place in _placesList) {
//           _markers.add(
//             Marker(
//               markerId: MarkerId(place.name),
//               position: LatLng(
//                 place.geometry!.location.lat,
//                 place.geometry!.location.lng,
//               ),
//               infoWindow: InfoWindow(
//                 title: place.name,
//                 snippet: place.formattedAddress,
//               ),
//             ),
//           );
//         }
//       });
//     } else {
//       print('Error: ${result.errorMessage}');
//     }
//   }



//   Future<void> _moveCameraToLocation(double latitude, double longitude) async {
//     final controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//       target: LatLng(latitude, longitude),
//       zoom: 15.0,
//     )));
//   }
// }
