import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:weathering_you/data/bloc/weather_handler_bloc.dart';
import 'package:weathering_you/data/utils/models/earthquake_model.dart';

late Map quakes;
late List features;

class Model {
  Model(this.state, this.color, this.stateCode);

  String state;
  Color color;
  String stateCode;
}

class EarthquakesPage extends StatefulWidget {
  const EarthquakesPage({Key? key}) : super(key: key);

  @override
  _EarthquakesPageState createState() => _EarthquakesPageState();
}

class _EarthquakesPageState extends State<EarthquakesPage> {
  Future? dataEqFuture;
  late List<Model> data;
  late MapShapeSource _mapSource;
  final MapShapeLayerController _layerController = MapShapeLayerController();
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior(
      showToolbar: true,
      toolbarSettings: MapToolbarSettings(
        position: MapToolbarPosition.topLeft,
        // iconColor: Colors.red,
        // itemBackgroundColor: Colors.green,
        // itemHoverColor: Colors.blue,
      ),
    );
    // _mapSource = MapShapeSource.asset(
    //   'assets/australia.json',
    //   shapeDataField: 'STATE_NAME',
    //   dataCount: data.length,
    //   primaryValueMapper: (int index) => data[index].state,
    //   dataLabelMapper: (int index) => data[index].stateCode,
    //   shapeColorValueMapper: (int index) => data[index].color,
    // );
    dataEqFuture = WeatherBloc().fetchEarthQuakeInfo(context);

//    features = quakes['features'];
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _layerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Align(
      alignment: Alignment.center,
      child: GlassContainer.clearGlass(
        height: MediaQuery.of(context).size.height - 100,
        width: MediaQuery.of(context).size.width - 100,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.40),
            Colors.white.withOpacity(0.10)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.60),
            Colors.white.withOpacity(0.10),
            Colors.lightBlueAccent.withOpacity(0.05),
            Colors.lightBlueAccent.withOpacity(0.6)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.39, 0.40, 1.0],
        ),
        blur: 8.0,
        borderRadius: BorderRadius.circular(12),
        borderColor: Colors.white54,
        borderWidth: 1.5,
        elevation: 3.0,
        //isFrostedGlass: true,
        shadowColor: Colors.black.withOpacity(0.20),
        alignment: Alignment.center,
        //   frostedOpacity: 0.12,
        margin: const EdgeInsets.only(bottom: 100, top: 32),
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            FutureBuilder(
              future: dataEqFuture,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  print("SNAPSHOT HAS DATA");
                  final earthQuake = snapshot.data as Earthquake;

                  return Center(
                    child: SfMaps(
                      layers: [
                        MapShapeLayer(
                          // color: Colors.white,
                          // showDataLabels: true,
                          // dataLabelSettings: MapDataLabelSettings(
                          //     textStyle:TextStyle(fontSize: 2.0)
                          // ),
                          zoomPanBehavior: _zoomPanBehavior,
                          onWillZoom: (MapZoomDetails c) {
                            return true;
                          },
                          onWillPan: (MapPanDetails p) {
                            return true;
                          },
                          // strokeColor: Colors.purple,
                          selectionSettings: const MapSelectionSettings(
                              color: Colors.yellow,
                              strokeColor: Colors.red,
                              strokeWidth: 1.2),
                          controller: _layerController,
                          source: const MapShapeSource.asset(
                            'assets/usa.json',
                            shapeDataField: 'name',
                          ),
                          initialMarkersCount: earthQuake.features.length,
                          markerBuilder: (BuildContext context, int index) {
                            double lat = earthQuake
                                .features[index].geometry.coordinates[0];
                            final long = earthQuake
                                .features[index].geometry.coordinates[1];
                            double mag =
                                earthQuake.features[index].properties.mag ?? 2;
                            // final d = getDoubleRandomV() + 0.7;
                            // mag = mag * d;
                            print("Printing MAG $mag");
                            return MapMarker(
                              latitude: lat,
                              longitude: long,
                              child: AvatarGlow(
                                  endRadius: mag * 3,
                                  glowColor: Colors.redAccent,
                                  animate: true,
                                  duration: Duration(milliseconds: 2000),
                                  repeat: true,
                                  child: Container(
                                    width: mag,
                                    height: mag,
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                  )),
                            );
                          },
                        ),
                      ],
                    ),

                    // child: ListView.builder(
                    //   itemCount: earthQuake.features.length,
                    //   itemBuilder: (context, index) {
                    //     final a = earthQuake.features[index].properties.place;
                    //     final aCd = earthQuake.features[index].geometry.coordinates;
                    //     return Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text("$index"),
                    //         Text("PLACE : $a"),
                    //        const SizedBox(height: 16.0,),
                    //         Text("CORD : $aCd"),
                    //       ],
                    //     );
                    //   },
                    // ),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text("EarthQuake"),
    //       centerTitle: true,
    //     ),
    //     body: Center(
    //       child: ListView.builder(
    //         itemCount: features.length,
    //         //padding: EdgeInsets.all(1.0),
    //         itemBuilder: (BuildContext context, int position) {
    //           if (position.isOdd) return Divider();
    //           final index = position ~/ 2;
    //           var format = DateFormat.yMMMd("en_US").add_jm();
    //           var date = format.format(DateTime.fromMicrosecondsSinceEpoch(
    //               features[index]['properties']['time'] * 1000,
    //               isUtc: true));
    //           return ListTile(
    //               //dense: true,
    //               leading: CircleAvatar(
    //                 radius: 40.0,
    //                 backgroundColor: Colors.blueAccent,
    //                 child: Text(
    //                   "${features[index]['properties']['mag']}",
    //                   style: TextStyle(
    //                       color: Colors.white, fontWeight: FontWeight.w600),
    //                 ),
    //               ),
    //               title: Row(
    //                 children: <Widget>[
    //                   Icon(Icons.location_on),
    //                   Text(
    //                     "${features[index]['properties']['place']}",
    //                     style: TextStyle(fontWeight: FontWeight.w700),
    //                     softWrap: true,
    //                     overflow: TextOverflow.visible,
    //                   ),
    //                 ],
    //               ),
    //               subtitle: Text(
    //                 "       $date",
    //                 style: TextStyle(
    //                     color: Colors.black26,
    //                     fontStyle: FontStyle.italic,
    //                     fontWeight: FontWeight.w500),
    //               ),
    //               onTap: () {
    //                 showAlertDialogue(
    //                     context, "${features[index]['properties']['title']}");
    //               });
    //         },
    //       ),
    //     ));
  }

// void showAlertDialogue(BuildContext context, String message) {
//   var alert = AlertDialog(
//     title: Text("Quakes"),
//     content: Text(message),
//     actions: <Widget>[
//       FlatButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text("OK"))
//     ],
//   );
//   // showDialog(
//   //     context: context, child: alert, builder: (BuildContext context) {});
// }
}

// Future<Map> getQuakes() async {
//   String apiUrl =
//       'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';
//   http.Response response = await http.get(Uri.parse(apiUrl));
//   return jsonDecode(response.body);
// }
