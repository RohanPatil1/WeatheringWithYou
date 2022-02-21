import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:weathering_you/data/bloc/weather_handler_bloc.dart';

import '../constant.dart';

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
        blur: 15.0,
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
              future: dataForecastFuture,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                print(
                    "snapshot.connectionState.index ${snapshot.connectionState.index}");
                if (snapshot.hasData) {
                  final wData = WeatherBloc().weatherForumData;
                  final astro = wData.forecast.forecastday[0].astro;
                  final day = wData.forecast.forecastday[0].day;
                  final current = wData.current;

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      margin: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 0.8, color: Colors.white)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.wb_sunny,
                                                color: Colors.orange,
                                                size: 20.0,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                "SUN ",
                                                style: commonTextStyle.copyWith(
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          Text("   Rise : ${astro.sunrise}",
                                              style: commonTextStyle.copyWith(
                                                  fontSize: 14.0,
                                                  color: Colors.white)),
                                          Text("   Set : ${astro.sunset}",
                                              style: commonTextStyle.copyWith(
                                                  fontSize: 14.0,
                                                  color: Colors.white)),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                FontAwesome5.moon,
                                                color: Colors.grey,
                                                size: 16.0,
                                              ),
                                              SizedBox(width: 4.0),
                                              Text(
                                                "MOON ",
                                                style: commonTextStyle.copyWith(
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          Text("   Rise : ${astro.moonrise}",
                                              style: commonTextStyle.copyWith(
                                                  fontSize: 14.0,
                                                  color: Colors.white)),
                                          Text("   Set : ${astro.moonset}",
                                              style: commonTextStyle.copyWith(
                                                  fontSize: 14.0,
                                                  color: Colors.white)),
                                          Text("   Phase : ${astro.moonPhase}",
                                              style: commonTextStyle.copyWith(
                                                  fontSize: 14.0,
                                                  color: Colors.white)),
                                          Text(
                                              "   Illumination : ${astro.moonIllumination} %",
                                              style: commonTextStyle.copyWith(
                                                  fontSize: 14.0,
                                                  color: Colors.white)),

                                          // Text("MOON "),
                                          // Text("RISE : ${astro.moonrise}"),
                                          // Text("SET : ${astro.moonset}"),
                                          // Text("PHASE : ${astro.moonPhase}"),
                                          // Text(
                                          //     "Illumination : ${astro.moonIllumination}"),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Transform.rotate(
                                            angle: -math.pi / 2,
                                            child: const Text(
                                              "GUST (in kph)",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w200),
                                            )),
                                        SfLinearGauge(
                                          showLabels: true,
                                          orientation:
                                              LinearGaugeOrientation.vertical,
                                          ranges: [
                                            LinearGaugeRange(
                                              startValue: 0,
                                              endValue: current.gustKph + 24,
                                              color: Colors.blue,
                                            ),
                                          ],
                                          markerPointers: [
                                            LinearShapePointer(
                                              value: current.gustKph,
                                              color: Colors.deepOrange,
                                            ),
                                          ],
                                          barPointers: [
                                            LinearBarPointer(
                                              value: current.gustKph,
                                              color: Colors.orangeAccent,
                                            )
                                          ],
                                        ),
                                        Transform.rotate(
                                            angle: -math.pi / 2,
                                            child: const Text(
                                              "PRESSURE (inches)",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w100),
                                            )),
                                        SfLinearGauge(
                                          showLabels: true,
                                          orientation:
                                              LinearGaugeOrientation.vertical,
                                          ranges: [
                                            LinearGaugeRange(
                                              startValue: 0,
                                              endValue: current.pressureIn + 45,
                                              color: Colors.blue,
                                            ),
                                          ],
                                          markerPointers: [
                                            LinearShapePointer(
                                              value: current.pressureIn,
                                              color: Colors.deepOrange,
                                            ),
                                          ],
                                          barPointers: [
                                            LinearBarPointer(
                                              value: current.pressureIn,
                                              color: Colors.orangeAccent,
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    margin: const EdgeInsets.all(16.0),
                                    // decoration: BoxDecoration(
                                    //     borderRadius:
                                    //         BorderRadius.circular(8.0),
                                    //     border: Border.all(
                                    //         color: Colors.yellow, width: 1.0)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  "MAX TEMP: ${day.maxtempC}°C",
                                                  style: commonTextStyle),
                                              SfLinearGauge(
                                                ranges: [
                                                  LinearGaugeRange(
                                                    startValue: 0,
                                                    endValue: day.maxtempC,
                                                  ),
                                                ],
                                                markerPointers: [
                                                  LinearShapePointer(
                                                    value: day.maxtempC,
                                                  ),
                                                ],
                                                barPointers: [
                                                  LinearBarPointer(
                                                      value: day.maxtempC + 33)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16.0,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  "MIN TEMP: ${day.mintempC}°C",
                                                  style: commonTextStyle),
                                              SfLinearGauge(ranges: [
                                                LinearGaugeRange(
                                                  startValue: 0,
                                                  endValue: day.mintempC,
                                                  color: Colors.red,
                                                ),
                                              ], markerPointers: [
                                                LinearShapePointer(
                                                  value: day.mintempC,
                                                ),
                                              ], barPointers: [
                                                LinearBarPointer(
                                                    value: day.mintempC + 22)
                                              ])
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SfRadialGauge(axes: <RadialAxis>[
                                            RadialAxis(
                                                minimum: 0,
                                                maximum: 100,
                                                ranges: <GaugeRange>[
                                                  GaugeRange(
                                                    startValue: 0,
                                                    endValue: 40,
                                                    gradient:
                                                        const SweepGradient(
                                                            colors: [
                                                          Colors.yellow,
                                                          Color(0xfff88379),
                                                        ]),
                                                  ),
                                                  GaugeRange(
                                                    startValue: 40,
                                                    endValue: 70,
                                                    gradient:
                                                        const SweepGradient(
                                                            colors: [
                                                          Color(0xfff88379),
                                                          Color(0xffff3800),
                                                        ]),
                                                  ),
                                                  GaugeRange(
                                                    startValue: 70,
                                                    endValue: 100,
                                                    gradient:
                                                        const SweepGradient(
                                                            colors: [
                                                          Color(0xffff3800),
                                                          Color(0xffff2400),
                                                        ]),
                                                  )
                                                ],
                                                pointers: <GaugePointer>[
                                                  NeedlePointer(
                                                      value: day.avghumidity
                                                          .toDouble())
                                                ],
                                                annotations: <GaugeAnnotation>[
                                                  GaugeAnnotation(
                                                      widget: Text(
                                                          "${day.avghumidity.toDouble()} %",
                                                          style: const TextStyle(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      angle: 90,
                                                      positionFactor: 0.5)
                                                ])
                                          ]),
                                          const Text(
                                            "Humidity",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SfRadialGauge(axes: <RadialAxis>[
                                            RadialAxis(
                                                minimum: 0,
                                                maximum: 100,
                                                ranges: <GaugeRange>[
                                                  GaugeRange(
                                                    startValue: 0,
                                                    endValue: 40,
                                                    gradient:
                                                        const SweepGradient(
                                                            colors: [
                                                          Color(0xff89CFF0),
                                                          Color(0xff00bfff),
                                                        ]),
                                                  ),
                                                  GaugeRange(
                                                    startValue: 40,
                                                    endValue: 70,
                                                    gradient:
                                                        const SweepGradient(
                                                            colors: [
                                                          Color(0xff00bfff),
                                                          Color(0xff007FFF),
                                                        ]),
                                                  ),
                                                  GaugeRange(
                                                    startValue: 70,
                                                    endValue: 100,
                                                    gradient:
                                                        const SweepGradient(
                                                            colors: [
                                                          Color(0xff007FFF),
                                                          // Color(0xff0f52ba),
                                                          Color(0xff120a8f),
                                                        ]),
                                                  )
                                                ],
                                                pointers: <GaugePointer>[
                                                  NeedlePointer(
                                                      value: day
                                                          .dailyChanceOfRain
                                                          .toDouble())
                                                ],
                                                annotations: <GaugeAnnotation>[
                                                  GaugeAnnotation(
                                                      widget: Text(
                                                          '${day.dailyChanceOfRain} %',
                                                          style: const TextStyle(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      angle: 90,
                                                      positionFactor: 0.5)
                                                ])
                                          ]),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          const Text(
                                            "Chances of Rain",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24.0),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 44),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      width: 0.8, color: Colors.white),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            FontAwesome5.compass,
                                            color: Colors.white,
                                            size: 18.0,
                                          ),
                                          const SizedBox(width: 8.0),
                                          Text(
                                            "Wind Direction: ${current.windDir} ",
                                            style: commonTextStyle.copyWith(
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            FontAwesome5.drafting_compass,
                                            color: Colors.white,
                                            size: 18.0,
                                          ),
                                          const SizedBox(width: 8.0),
                                          Text(
                                            "Wind Degree: ${current.windDegree}° ",
                                            style: commonTextStyle.copyWith(
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 32,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      "WIND SPEED (in kph)",
                                      style: commonTextStyle,
                                    ),
                                    SfLinearGauge(
                                      ranges: [
                                        LinearGaugeRange(
                                          startValue: 0,
                                          endValue:
                                              day.maxwindKph.toDouble() + 30.0,
                                          color: colorComb11,
                                        ),
                                      ],
                                      markerPointers: [
                                        LinearShapePointer(
                                          value: day.maxwindKph.toDouble(),
                                          color: colorComb12,
                                        ),
                                      ],
                                      barPointers: [
                                        LinearBarPointer(
                                          value: day.maxwindKph.toDouble(),
                                          color: colorComb13,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        // Flexible(
                        //   child: Container(
                        //     height: 500.0,
                        //     width: 500,
                        //     child: ListView.builder(
                        //       physics: NeverScrollableScrollPhysics(),
                        //       shrinkWrap: true,
                        //       itemCount: wData.forecast.forecastday.length,
                        //       itemBuilder: (context, index) {
                        //         final day =
                        //             wData.forecast.forecastday[index].day;
                        //         final current = wData.current;
                        //         final conditon = wData
                        //             .forecast.forecastday[index].day.condition;
                        //         return Column(
                        //           children: [
                        //             //---------------------
                        //             Text("windDegree ${current.windDegree}"),
                        //             Text("windDir ${current.windDir}"),
                        //             Text("pressureMb ${current.pressureMb}"),
                        //             Text("pressureIn ${current.pressureIn}"),
                        //             Text("precipMm ${current.precipMm}"),
                        //             Text("precipIn ${current.precipIn}"),
                        //             Text("humidity ${current.humidity}"),
                        //             Text("feelslikeC ${current.feelslikeC}"),
                        //             Text("feelslikeF ${current.feelslikeF}"),
                        //             Text("visKm ${current.visKm}"),
                        //             Text("visMiles ${current.visMiles}"),
                        //             Text("uv ${current.uv}"),
                        //             Text("gustMph ${current.gustMph}"),
                        //             Text("gustKph ${current.gustKph}"),
                        //             //---------------------
                        //
                        //             // Text("mintempC ${day.mintempC}"),
                        //             // Text("avgtempC ${day.avgtempC}"),
                        //             Text("maxwindMph ${day.maxwindMph}"),
                        //             Text("maxwindKph ${day.maxwindKph}"),
                        //             Text("avghumidity ${day.avghumidity}"),
                        //             Text(
                        //                 "dailyWillItRain ${day.dailyWillItRain}"),
                        //             Text(
                        //                 "dailyChanceOfRain ${day.dailyChanceOfRain}"),
                        //             // Text("dailyWillItSnow ${day.dailyWillItSnow}"),
                        //             // Text(
                        //             //     "dailyChanceOfSnow ${day.dailyChanceOfSnow}"),
                        //             Text("uv ${day.uv}"),
                        //             // Text("conditon  ${conditon.text}"),
                        //           ],
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
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
  }
}
