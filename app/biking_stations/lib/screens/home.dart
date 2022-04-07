import 'dart:convert';

import 'package:biking_stations/main.dart';
import 'package:biking_stations/screens/navigate.dart';
import 'package:flutter/material.dart';

import '../constants/bike_stations.dart';
import '../widgets/stations_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String id = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String name, address;
  List<String> stationDistances = sharedPreferences.getStringList('distances')!;
  List<bool> selectedStation = List.generate(4, (index) => false);

  @override
  void initState() {
    Map currentLocation = json.decode(sharedPreferences.getString('location')!);
    name = currentLocation['name'];
    address = currentLocation['address'];
    super.initState();
  }

  void handleStartTrip() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                Navigate(stationIndex: selectedStation.indexOf(true))));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stationDetails = List.generate(
      4,
      (index) => GestureDetector(
        onTap: () {
          setState(() {
            selectedStation = List.generate(4, (index) => false);
            selectedStation[index] = true;
          });
        },
        child: StationsCard(
            name: bikeStations[index]['name'],
            distance: stationDistances[index],
            imageUrl: bikeStations[index]['image'],
            isSelected: selectedStation[index]),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Stations near you')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your location',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 15),
              Row(
                children: [
                  Image.asset('assets/icon/maps.png', height: 60, width: 60),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text(address),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: const [
                              Icon(Icons.explore,
                                  size: 16, color: Colors.deepPurple),
                              SizedBox(width: 3),
                              Text('See on map',
                                  style: TextStyle(color: Colors.deepPurple))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Text('Stations nearby',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 15),
              GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: stationDetails,
              ),
              const Spacer(),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(15)),
                child: const Center(child: Text('Start my trip')),
                onPressed:
                    selectedStation.contains(true) ? handleStartTrip : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
