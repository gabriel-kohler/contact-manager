import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ContactMarker extends Marker {
  ContactMarker({
    Key? key,
    required this.lat,
    required this.lng,
    required this.onTap,
    required this.child,
  }) : super(
    key: key,
    builder: (_) => GestureDetector(
      onTap: onTap,
      child: child,
    ),
    point: LatLng(lat, lng),
  );

  final double lat;
  final double lng;
  final Widget child;

  VoidCallback onTap;
}