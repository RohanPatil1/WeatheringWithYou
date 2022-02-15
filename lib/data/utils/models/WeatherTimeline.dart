//https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Mumbai,IN/last30days?unitGroup=us&key=H9XR549M85FW7X293VKDNWSVC&include=days&elements=datetime,tempmax,tempmin
class WeatherTimeline {
  WeatherTimeline({
    required this.queryCost,
    required this.latitude,
    required this.longitude,
    required this.resolvedAddress,
    required this.address,
    required this.timezone,
    required this.tzoffset,
    required this.days,
  });

  late final int queryCost;
  late final double latitude;
  late final double longitude;
  late final String resolvedAddress;
  late final String address;
  late final String timezone;
  late final double tzoffset;
  late final List<Days> days;

  WeatherTimeline.fromJson(Map<String, dynamic> json) {
    queryCost = json['queryCost'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    resolvedAddress = json['resolvedAddress'];
    address = json['address'];
    timezone = json['timezone'];
    tzoffset = json['tzoffset'];
    days = List.from(json['days']).map((e) => Days.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['queryCost'] = queryCost;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['resolvedAddress'] = resolvedAddress;
    _data['address'] = address;
    _data['timezone'] = timezone;
    _data['tzoffset'] = tzoffset;
    _data['days'] = days.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Days {
  Days({
    required this.datetime,
    required this.tempmax,
    required this.tempmin,
  });

  late final String datetime;
  late final int? tempmax;
  late final double? tempmin;

  Days.fromJson(Map<String, dynamic> json) {
    datetime = json['datetime'];
    tempmax = json['tempmax'];
    tempmin = json['tempmin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['datetime'] = datetime;
    _data['tempmax'] = tempmax;
    _data['tempmin'] = tempmin;
    return _data;
  }
}
