class AirQualityData {
  AirQualityData({
    required this.coord,
    required this.list,
  });

  late final Coord coord;
  late final List<DataList> list;

  AirQualityData.fromJson(Map<String, dynamic> json) {
    //coord = Coord.fromJson(json['coord']);
    list = List.from(json['list']).map((e) => DataList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coord'] = coord.toJson();
    _data['list'] = list.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });

  late final double lon;
  late final double lat;

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
    // dt = json['dt'];
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
  late final double no;
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