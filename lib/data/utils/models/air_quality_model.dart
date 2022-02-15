/*
http://api.openweathermap.org/data/2.5/air_pollution?lat=50&lon=50&appid=551bceb1825daa3ff74a9f59e7c076b6



 coord Coordinates from the specified location (latitude, longitude)
list
dt Date and time, Unix, UTC
main
main.aqi Air Quality Index. Possible values: 1, 2, 3, 4, 5. Where 1 = Good, 2 = Fair, 3 = Moderate, 4 = Poor, 5 = Very Poor.
components
components.co Сoncentration of CO (Carbon monoxide), μg/m3
components.no Сoncentration of NO (Nitrogen monoxide), μg/m3
components.no2 Сoncentration of NO2 (Nitrogen dioxide), μg/m3
components.o3 Сoncentration of O3 (Ozone), μg/m3
components.so2 Сoncentration of SO2 (Sulphur dioxide), μg/m3
components.pm2_5 Сoncentration of PM2.5 (Fine particles matter), μg/m3
components.pm10 Сoncentration of PM10 (Coarse particulate matter), μg/m3
components.nh3 Сoncentration of NH3 (Ammonia), μg/m3
 */

import 'package:flutter/cupertino.dart';

class AirQuality {
  AirQuality({
    required this.coord,
    required this.dataList,
  });

  Coord coord = Coord(lon: 0, lat: 0);
  List<DataList> dataList = [];

  AirQuality.fromJson(Map<String, dynamic> json) {
    // coord = Coord.fromJson(json['coord']);
    debugPrint("FROM JSON");

    dataList =
        List.from(json['list']).map((e) => DataList.fromJson(e)).toList();
    debugPrint("GOT LIST");
    debugPrint(dataList.toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coord'] = coord.toJson();
    _data['list'] = dataList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  late final int lon;
  late final int lat;

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lon'] = lon;
    _data['lat'] = lat;
    return _data;
  }
}

class DataList {
  DataList({
    required this.main,
    required this.components,
    required this.dt,
  });

  late final Main main;
  late final Components components;
  late final int dt;

  DataList.fromJson(Map<String, dynamic> json) {
    main = Main.fromJson(json['main']);
    components = Components.fromJson(json['components']);
    dt = json['dt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['main'] = main.toJson();
    _data['components'] = components.toJson();
    _data['dt'] = dt;
    return _data;
  }
}

class Main {
  Main({
    required this.aqi,
  });

  late final int aqi;

  Main.fromJson(Map<String, dynamic> json) {
    aqi = json['aqi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['aqi'] = aqi;
    return _data;
  }
}

class Components {
  Components({
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });

  late final double co;
  late final int no;
  late final double no2;
  late final double o3;
  late final double so2;
  late final double pm2_5;
  late final double pm10;
  late final double nh3;

  Components.fromJson(Map<String, dynamic> json) {
    co = json['co'];
    no = json['no'];
    no2 = json['no2'];
    o3 = json['o3'];
    so2 = json['so2'];
    pm2_5 = json['pm2_5'];
    pm10 = json['pm10'];
    nh3 = json['nh3'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['co'] = co;
    _data['no'] = no;
    _data['no2'] = no2;
    _data['o3'] = o3;
    _data['so2'] = so2;
    _data['pm2_5'] = pm2_5;
    _data['pm10'] = pm10;
    _data['nh3'] = nh3;
    return _data;
  }
}
