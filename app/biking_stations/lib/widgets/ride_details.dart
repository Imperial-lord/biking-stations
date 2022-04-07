import 'package:flutter/material.dart';

Widget rideDetails(BuildContext context, String stationName, String distance,
    int stationCount) {
  return Positioned(
    bottom: 0,
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListTile(
            leading: const Image(
                image: AssetImage('assets/icon/bicycle.png'),
                height: 50,
                width: 50),
            title: Text(stationName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('$distance km away'),
            trailing: ElevatedButton(
              onPressed: () {},
              child: Text('$stationCount slots',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
        ),
      ),
    ),
  );
}
