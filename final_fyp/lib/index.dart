// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = 'AIzaSyAT8pCVh8o7Q9IoYxBRJ7WJ3ndmw1NZCAk';
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController _mapController ;
  final TextEditingController _searchController = TextEditingController();
  LatLng _center = const LatLng(45.521563, -122.677433);
  List<PlacesSearchResult> _placesList = [];

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _searchPlace(String query) async {
    final location = Location(_center.latitude, _center.longitude);
    final result = await _places.searchByText(query, location: location);

    if (result.status == 'OK') {
      setState(() {
        _placesList = result.results;
      });
    } else {
      print('Error: ${result.errorMessage}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            ),
            onSubmitted: (value) {
              _searchPlace(value);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                markers: Set<Marker>.of(_placesList.map((place) {
                  final marker = Marker(
                    markerId: MarkerId(place.id),
                    position: LatLng(
                      place.geometry.location.lat,
                      place.geometry.location.lng,
                    ),
                    infoWindow: InfoWindow(
                      title: place.name,
                      snippet: place.formattedAddress,
                    ),
                  );
                  _mapController.showMarkerInfoWindow(marker.markerId);
                  return marker;
                })),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (BuildContext context, int index) {
                  final place = _placesList[index];
                  return ListTile(
                    title: Text(place.name),
                    subtitle: Text(place.formattedAddress),
                    onTap: () {
                      final LatLng position = LatLng(
                        place.geometry.location.lat,
                        place.geometry.location.lng,
                      );
                      _mapController
                          .animateCamera(CameraUpdate.newLatLng(position));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}