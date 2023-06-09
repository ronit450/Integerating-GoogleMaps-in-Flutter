import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final String title = 'Ragni FYP';

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late GoogleMapController mapController;
  String searchQuery = '';
  List<Location> searchResults = [];

  final LatLng _center = const LatLng(24.8270, 67.0251);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onSearch(String query) async {
    List<Location> locations = await locationFromAddress(query);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(location.latitude, location.longitude), zoom: 15.0)));

      setState(() {
        searchQuery = query;
        searchResults = locations;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
            Positioned(
              top: 50.0,
              left: 10.0,
              right: 10.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0.0, 0.0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10.0),
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search for a location',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        onSubmitted: _onSearch,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (searchResults.isNotEmpty)
              Positioned(
                bottom: 10.0,
                left: 10.0,
                child: Container(
                  height: 200.0,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        // title: Text(searchResults[index].formattedAddress ?? ''),
                        onTap: () async {
                        final location = searchResults[index];
                        mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(location.latitude, location.longitude),
                              zoom: 15.0,
                            ),
                          ),
                        );
                        setState(() {
                          searchResults = [];
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


