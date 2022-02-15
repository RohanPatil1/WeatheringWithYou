import 'package:flutter/material.dart';
import 'package:weathering_you/data/bloc/weather_handler_bloc.dart';

import '../data/utils/models/air_quality_model.dart';

class AirQualityPage extends StatefulWidget {
  const AirQualityPage({Key? key}) : super(key: key);

  @override
  _AirQualityPageState createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  Future? dataAirFuture;

  @override
  void initState() {
    dataAirFuture = WeatherBloc().fetchAirQualityInfo();
    setState(() {});
    // WeatherBloc().fetchCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: dataAirFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              print("SNAPSHOT HAS DATA");
              final airData = snapshot.data as AirQuality;

              return ListView.builder(
                itemCount: airData.dataList.length,
                itemBuilder: (context, index) {
                  final a = airData.dataList[index].main.aqi.toString();
                  return Text("AIR INDEX : $a");
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}
