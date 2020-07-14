import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String useQueryString(String baseUrl, Map<String, String> params) =>
    params.map((key, value) => MapEntry(key, '$key=$value')).values.join('&');

final _dio = Dio();
Future<dynamic> useDirections(
        LatLng origin, LatLng destiny, String key) async =>
    await _dio.get(useQueryString(
        'https://maps.googleapis.com/maps/api/directions/json?', {
      "origin": origin.toString(),
      "destination": destiny.toString(),
      "key": key
    }));
