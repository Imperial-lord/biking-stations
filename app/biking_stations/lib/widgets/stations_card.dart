import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StationsCard extends StatefulWidget {
  final String name, distance, imageUrl;
  final bool isSelected;

  const StationsCard(
      {Key? key,
      required this.name,
      required this.distance,
      required this.isSelected,
      required this.imageUrl})
      : super(key: key);

  @override
  State<StationsCard> createState() => _StationsCardState();
}

class _StationsCardState extends State<StationsCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: (widget.isSelected) ? Colors.deepPurple[50] : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: widget.imageUrl,
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              '${widget.distance} kms away',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.deepPurple),
            ),
          ),
        ],
      ),
    );
  }
}
