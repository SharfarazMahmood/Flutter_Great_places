// const GOOGLE_API_KEY = "" ;

import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    // return "https://drive.google.com/drive/u/0/folders/1Vx_zLQYrs9y33hYk1gAUqloCjNwve9oc" ;

    return "returned from generateLocationPreviewImage in LocationHelper";
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    // final googleMapApiUrl = Uri.parse("google map api url should be here");

    // final response = await http.get(googleMapApiUrl);
    // final result = json.decode(response.body)['results'][0]['formatted_address'];
    // return result;
    return "returned from getPlaceAddress in LocationHelper";
  }
}
