// ----------------------------- Mapbox Reverse Geocoding -----------------------------
import 'package:biking_stations/constants/bike_stations.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../requests/mapbox_directions.dart';
import '../requests/mapbox_revgeocode.dart';

Future<Map> getParsedReverseGeocoding(LatLng latLng) async {
  var response = await getReverseGeocodingGivenLatLngUsingMapbox(latLng);
  Map feature = response['features'][0];
  Map revGeocode = {
    'name': feature['text'],
    'address': feature['place_name'].split('${feature['text']}, ')[1],
    'place': feature['place_name'],
    'location': latLng
  };
  return revGeocode;
}

Future<Map> getDirectionsAPIResponse(LatLng currentLatLng, int index) async {
  final response = await getCyclingRouteUsingMapbox(
      currentLatLng,
      LatLng(double.parse(bikeStations[index]['coordinates']['latitude']),
          double.parse(bikeStations[index]['coordinates']['longitude'])));
  Map geometry = response['routes'][0]['geometry'];
  num duration = response['routes'][0]['duration'];
  num distance = response['routes'][0]['distance'];
  print('-------------------${bikeStations[index]['name']}-------------------');
  print(distance);
  print(duration);

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };
  return modifiedResponse;
}
