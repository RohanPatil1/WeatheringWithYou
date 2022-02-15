//      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';

class Earthquake {
  Earthquake({
    required this.type,
    required this.metadata,
    required this.features,
    required this.bbox,
  });

  late final String type;
  late final Metadata metadata;
  late final List<Features> features;
  late final List<double> bbox;

  Earthquake.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    metadata = Metadata.fromJson(json['metadata']);
    features =
        List.from(json['features']).map((e) => Features.fromJson(e)).toList();
    bbox = List.castFrom<dynamic, double>(json['bbox']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['metadata'] = metadata.toJson();
    _data['features'] = features.map((e) => e.toJson()).toList();
    _data['bbox'] = bbox;
    return _data;
  }
}

class Metadata {
  Metadata({
    required this.generated,
    required this.url,
    required this.title,
    required this.status,
    required this.api,
    required this.count,
  });

  late final int generated;
  late final String url;
  late final String title;
  late final int status;
  late final String api;
  late final int count;

  Metadata.fromJson(Map<String, dynamic> json) {
    generated = json['generated'];
    url = json['url'];
    title = json['title'];
    status = json['status'];
    api = json['api'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['generated'] = generated;
    _data['url'] = url;
    _data['title'] = title;
    _data['status'] = status;
    _data['api'] = api;
    _data['count'] = count;
    return _data;
  }
}

class Features {
  Features({
    required this.type,
    required this.properties,
    required this.geometry,
    required this.id,
  });

  late final String type;
  late final Properties properties;
  late final Geometry geometry;
  late final String id;

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = Properties.fromJson(json['properties']);
    geometry = Geometry.fromJson(json['geometry']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['properties'] = properties.toJson();
    _data['geometry'] = geometry.toJson();
    _data['id'] = id;
    return _data;
  }
}

class Properties {
  Properties({
    required this.mag,
    required this.place,
    required this.time,
    required this.updated,
    required this.url,
    required this.detail,
    this.felt,
    this.cdi,
    this.mmi,
    required this.status,
    required this.tsunami,
    required this.sig,
    required this.net,
    required this.code,
    required this.ids,
    required this.sources,
    required this.types,
    this.nst,
    this.dmin,
    required this.rms,
    this.gap,
    required this.magType,
    required this.type,
    required this.title,
  });

  late final double? mag;
  late final String place;
  late final int time;
  late final int updated;

  late final String url;
  late final String detail;
  late final int? felt;
  late final double? cdi;
  late final double? mmi;

  late final String status;
  late final int tsunami;
  late final int sig;
  late final String net;
  late final String code;
  late final String ids;
  late final String sources;
  late final String types;
  late final int? nst;
  late final double? dmin;
  late final double? rms;
  late final int? gap;
  late final String magType;
  late final String type;
  late final String title;

  Properties.fromJson(Map<String, dynamic> json) {
    mag = json['mag'];
    place = json['place'];
    time = json['time'];
    updated = json['updated'];

    url = json['url'];
    detail = json['detail'];
    felt = null;
    cdi = null;
    mmi = null;

    status = json['status'];
    tsunami = json['tsunami'];
    sig = json['sig'];
    net = json['net'];
    code = json['code'];
    ids = json['ids'];
    sources = json['sources'];
    types = json['types'];
    nst = null;
    dmin = null;
    rms = json['rms'];
    gap = null;
    magType = json['magType'];
    type = json['type'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mag'] = mag;
    _data['place'] = place;
    _data['time'] = time;
    _data['updated'] = updated;

    _data['url'] = url;
    _data['detail'] = detail;
    _data['felt'] = felt;
    _data['cdi'] = cdi;
    _data['mmi'] = mmi;

    _data['status'] = status;
    _data['tsunami'] = tsunami;
    _data['sig'] = sig;
    _data['net'] = net;
    _data['code'] = code;
    _data['ids'] = ids;
    _data['sources'] = sources;
    _data['types'] = types;
    _data['nst'] = nst;
    _data['dmin'] = dmin;
    _data['rms'] = rms;
    _data['gap'] = gap;
    _data['magType'] = magType;
    _data['type'] = type;
    _data['title'] = title;
    return _data;
  }
}

class Geometry {
  Geometry({
    required this.type,
    required this.coordinates,
  });

  late final String type;
  late final List<double> coordinates;

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = List.castFrom<dynamic, double>(json['coordinates']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['coordinates'] = coordinates;
    return _data;
  }
}
