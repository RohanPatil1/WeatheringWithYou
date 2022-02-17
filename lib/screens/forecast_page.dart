import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
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
              final astro = wData.forecast.forecastday[0].astro;
              final day = wData.forecast.forecastday[0].day;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            margin: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                    color: Colors.yellow, width: 1.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text("SUN "),
                                Text("RISE : ${astro.sunrise}"),
                                Text("SET : ${astro.sunset}"),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text("MOON "),
                                Text("RISE : ${astro.moonrise}"),
                                Text("SET : ${astro.moonset}"),
                                Text("PHASE : ${astro.moonPhase}"),
                                Text(
                                    "Illumination : ${astro.moonIllumination}"),
                                const SizedBox(
                                  height: 8.0,
                                ),
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: Colors.yellow, width: 1.0)),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("MAX TEMP ${day.maxtempF}"),
                                    SfLinearGauge(ranges: [
                                      LinearGaugeRange(
                                        startValue: 0,
                                        endValue: day.maxtempF,
                                      ),
                                    ], markerPointers: [
                                      LinearShapePointer(
                                        value: day.maxtempF,
                                      ),
                                    ], barPointers: [
                                      LinearBarPointer(value: 80)
                                    ])
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("MIN TEMP ${day.mintempF}"),
                                    SfLinearGauge(ranges: [
                                      LinearGaugeRange(
                                        startValue: 0,
                                        endValue: day.maxtempF,
                                      ),
                                    ], markerPointers: [
                                      LinearShapePointer(
                                        value: day.maxtempF,
                                      ),
                                    ], barPointers: [
                                      LinearBarPointer(value: day.maxtempF + 20)
                                    ])
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Container(
                      height: 500.0,
                      width: 500,
                      child: ListView.builder(
                        itemCount: wData.forecast.forecastday.length,
                        itemBuilder: (context, index) {
                          final day = wData.forecast.forecastday[index].day;
                          final conditon =
                              wData.forecast.forecastday[index].day.condition;
                          return Column(
                            children: [
                              // Text("mintempC ${day.mintempC}"),
                              // Text("avgtempC ${day.avgtempC}"),
                              Text("maxwindMph ${day.maxwindMph}"),
                              Text("maxwindKph ${day.maxwindKph}"),
                              Text("avghumidity ${day.avghumidity}"),
                              // Text("dailyWillItRain ${day.dailyWillItRain}"),
                              // Text(
                              //     "dailyChanceOfRain ${day.dailyChanceOfRain}"),
                              // Text("dailyWillItSnow ${day.dailyWillItSnow}"),
                              // Text(
                              //     "dailyChanceOfSnow ${day.dailyChanceOfSnow}"),
                              // Text("uv ${day.uv}"),
                              // Text("conditon  ${conditon.text}"),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
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
