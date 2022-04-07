import 'package:biking_stations/screens/home.dart';
import 'package:biking_stations/screens/navigate.dart';

final routes = {
  Home.id: (context) => const Home(),
  Navigate.id: (context) => const Navigate(stationIndex: 0),
};
