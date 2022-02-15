import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weathering_you/data/utils/models/air_quality_model.dart';
import 'package:weathering_you/data/utils/models/earthquake_model.dart';
import 'package:weathering_you/data/utils/models/geocoding_model.dart';
import 'package:weathering_you/data/utils/network/call_api.dart';

import '../../constant.dart';

class WeatherBloc extends ChangeNotifier {
  static final WeatherBloc _instance = WeatherBloc._internal();

  factory WeatherBloc() => _instance;

  WeatherBloc._internal();

  final TextEditingController searchCtrl = TextEditingController();
  String currLocation = "";
  double currentLat = 51.5072;
  double currentLong = 0.1276;
  late Earthquake earthquakeData;

  Future<Earthquake> fetchEarthQuakeInfo(BuildContext context) async {
    String apiUrl =
        'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_month.geojson';

    //  final data = await getCallApi(apiUrl);
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/equakes.json");
    final jsonResult = jsonDecode(data); //latest Dart
    earthquakeData = Earthquake.fromJson(jsonResult);
    notifyListeners();
    return Earthquake.fromJson(jsonResult);
  }

  Future<AirQuality> fetchAirQualityInfo() async {
    final data = await getCallApi(
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$currentLat&lon=$currentLong&appid=$OPEN_WEATHER_API");

    print("Printing Data");
    // print(data);

    var aq = AirQuality.fromJson(data);
    print("=============");

    print(aq.dataList[0].components.nh3);
    return AirQuality.fromJson(data);

    /*
http://api.openweathermap.org/data/2.5/air_pollution?lat=50&lon=50&appid=551bceb1825daa3ff74a9f59e7c076b6
 */
  }

  Future fetchCurrentLocation() async {
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.low);
    //
    // double longitude = position.longitude;
    // double latitude = position.latitude;

    currentLat = 73.1455749;
    currentLong = 19.2579931;
    // print("LONG: $longitude");
    // print("LAT: $latitude");
  }

  //Get LatLng from City Name using fetchSearchLocation()
  onLocationSearch(String location) {
    currLocation = location;
    fetchSearchLocation(currLocation);

    notifyListeners();
  }

  fetchSearchLocation(String city) async {
    final data = await getCallApi(
        "http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$OPEN_WEATHER_API");

    final geoData = GeocodingData.fromJson(data);
    currentLong = geoData.lon;
    currentLat = geoData.lat;
    print("Current LAT LONG : {$currentLat, $currentLong}");
    notifyListeners();
  }
}
