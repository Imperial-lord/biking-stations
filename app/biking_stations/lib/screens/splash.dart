import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/mapbox_handler.dart';
import '../main.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    initializeLocationAndSave();
    super.initState();
  }

  void initializeLocationAndSave() async {
    // Ensure all permissions are collected for Locations
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    // Get capture the current user location
    LocationData _locationData = await _location.getLocation();
    LatLng currentLatLng =
        LatLng(_locationData.latitude!, _locationData.longitude!);
    Map currentLocation = await getParsedReverseGeocoding(currentLatLng);

    List<String> stationDistance = List.generate(4, (index) => '0');
    for (int i = 0; i < 4; i++) {
      stationDistance[i] =
          ((await getDirectionsAPIResponse(currentLatLng, i))['distance'] /
                  1000)
              .toStringAsFixed(2);
    }

    // Store the user location in sharedPreferences
    sharedPreferences.setString('location', json.encode(currentLocation));
    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);
    sharedPreferences.setStringList('distances', stationDistance);

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icon/splash.png', height: 120, width: 120),
              Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 5),
                  child: Text('Biking Stations',
                      style: Theme.of(context).textTheme.titleLarge)),
              const Text('Find the nearest biking stations at your fingertip!'),
            ],
          ),
        ),
      ),
    );
  }
}
