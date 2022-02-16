import 'package:flutter/material.dart';
import 'package:weathering_you/data/bloc/weather_handler_bloc.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  Future? dataForecastFuture;

  @override
  void initState() {
    dataForecastFuture = WeatherBloc().getForecastInfo(context);
    setState(() {});
    // WeatherBloc().fetchCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: dataForecastFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print(
                "snapshot.connectionState.index ${snapshot.connectionState.index}");
            if (snapshot.hasData) {
              final wData = WeatherBloc().weatherForumData;
              print("SNAPSHOT HAS DATA ${wData.forecast.forecastday.length}");

              return ListView.builder(
                itemCount: wData.forecast.forecastday.length,
                itemBuilder: (context, index) {
                  final a =
                      wData.forecast.forecastday[index].astro.moonIllumination;
                  return Text("AVG TEMP : $a");
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
