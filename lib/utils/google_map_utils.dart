import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../general_exports.dart';

void animateGoogleMapCamera(
  GoogleMapController mapController,
  double lat,
  double lng, {
  double? zoom = 18.0,
  // Not implemented yet in google map flutter https://github.com/flutter/flutter/issues/39810
  int? duration = 4000,
}) {
  mapController.animateCamera(
    CameraUpdate.newLatLngZoom(
      LatLng(lat, lng),
      zoom!,
    ),
  );
}

// This function return a bitmap descriptor for cluster marker, it shows the number of markers in cluster
Future<BitmapDescriptor> getLabeledClusterBitmap({
  int size = 135,
  String? text,
}) async {
  final PictureRecorder pictureRecorder = PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint fillPaint = Paint()..color = Colors.white;
  final Paint borderPaint = Paint()
    ..strokeWidth = 8
    ..color = const Color(AppColors.primary).withOpacity(0.3)
    ..style = PaintingStyle.stroke;

  canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, fillPaint);
  canvas.drawCircle(Offset(size / 2, size / 2), size / 2.15, borderPaint);

  final TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
  painter.text = TextSpan(
    text: text,
    style: TextStyle(
      fontSize: size / 3,
      color: const Color(AppColors.primary),
      fontWeight: FontWeight.bold,
    ),
  );
  painter.layout();
  painter.paint(
    canvas,
    Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
  );

  final dynamic img = await pictureRecorder.endRecording().toImage(size, size);
  final ByteData? data = await img.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}

void fitCameraBasedOnLatLngList(
  GoogleMapController? mapController,
  List<LatLng> latLngList, {
  bool withAnimation = true,
  double padding = 70.0,
}) {
  if (latLngList.length == 1) {
    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(latLngList.first, 16.0),
    );
    return;
  }
  LatLngBounds? bounds;
  if (latLngList.isNotEmpty) {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;
    for (LatLng latLng in latLngList) {
      minLat = min(minLat, latLng.latitude);
      maxLat = max(maxLat, latLng.latitude);
      minLng = min(minLng, latLng.longitude);
      maxLng = max(maxLng, latLng.longitude);
    }
    bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
    if (withAnimation) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, padding),
      );
    } else {
      mapController!.moveCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
    }
  }
}
