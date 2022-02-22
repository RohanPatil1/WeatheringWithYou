import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:weathering_you/data/utils/models/air_quality_model.dart';
import 'package:weathering_you/data/utils/models/earthquake_model.dart';
import 'package:weathering_you/data/utils/models/geocoding_model.dart';
import 'package:weathering_you/data/utils/models/news_data_model.dart';
import 'package:weathering_you/data/utils/models/weather_forum_model.dart';
import 'package:weathering_you/data/utils/network/call_api.dart';

import '../../constant.dart';

class WeatherBloc extends ChangeNotifier {
  static final WeatherBloc _instance = WeatherBloc._internal();

  factory WeatherBloc() => _instance;

  WeatherBloc._internal();

  final TextEditingController searchCtrl = TextEditingController();
  String currLocation = "";
  double currentLat = 28.6517178;
  double currentLong = 77.2219388;
  late Earthquake earthquakeData;
  late WeatherForum weatherForumData;
  late NewsData newsData;

  Future<bool> getForecastInfo(BuildContext context) async {
    //API WORKING CHECKED
    // String apiUrl =
    //     "http://api.weatherapi.com/v1/forecast.json?key=dc563094f79548d09fa151653220702&q=Mumbai&days=7";
    // final data = await getCallApi(apiUrl);

    String data =
        await DefaultAssetBundle.of(context).loadString("assets/forecast.json");
    final jsonResult = jsonDecode(data); //latest Dart
    print("Printing Info");

    weatherForumData = WeatherForum.fromJson(jsonResult);
    print(weatherForumData.forecast.forecastday.length);
    notifyListeners();
    // return Earthquake.fromJson(jsonResult);
    return true;
  }

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

  Future<NewsData> fetchNewsData(BuildContext context) async {
    String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$NEWS_API';

    // final data = jsonDecode(tempNewsData);
    // final data = await getCallApi(apiUrl);
//    print(data);
    // String data =
    // await DefaultAssetBundle.of(context).loadString("assets/equakes.json");
    // final jsonResult = jsonDecode(data); //latest Dart
    newsData = NewsData.fromJson(tempNewsData);
    notifyListeners();
    return newsData;
  }

  Future<AirQualityData> fetchAirQualityInfo() async {
    final data = await getCallApi(
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$currentLat&lon=$currentLong&appid=$OPEN_WEATHER_API");

    // const airJsonData = '{"coord":{"lon":0.1276,"lat":51.5072},"list":[{"main":{"aqi":1},"components":{"co":250.34,"no":1.34,"no2":9.08,"o3":76.53,"so2":5.31,"pm2_5":3.23,"pm10":3.87,"nh3":0.81},"dt":1645542000}]}';
    //
    // final data =jsonDecode(airJsonData) ;
    debugPrint("Printing Data");
    // debugPrint(data);

    var aq = AirQualityData.fromJson(data);
    print("=============");

    print(aq.list[0].components.nh3);
    return AirQualityData.fromJson(data);

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

    currentLat = 751.5072;
    currentLong = 0.1276;
    // print("LONG: $longitude");
    // print("LAT: $latitude");
  }

  //Get LatLng from City Name using fetchSearchLocation()
  onLocationSearch(String location) {
    debugPrint("onLocationSearch");
    currLocation = location;
    fetchSearchLocation(currLocation);

    notifyListeners();
  }

  fetchSearchLocation(String city) async {
    debugPrint("fetchSearchLocation");

    final data = await getCallApi(
        "http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$OPEN_WEATHER_API");

    final geoData = GeocodingData.fromJson(data[0]);
    currentLong = geoData.lon;
    currentLat = geoData.lat;
    debugPrint("Current LAT LONG : {$currentLat, $currentLong}");
    notifyListeners();
  }
}
