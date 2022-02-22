import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Map<String, String> gasNames = {
    "co": "Carbon Monoxide (CO)",
    "no": "Nitric Oxide (NO)",
    "no2": "Nitrogen Dioxide (NO2)",
    "o3": "Ozone (O3)",
    "so2": "Sulfur dioxide (SO2)",
    "pm2_5": "Fine particulate matter (PM2.5)",
    "pm10": "Particulate Matter (PM10)",
    "nh3": "Ammonia (NH3)",
  };

  Map<int, Color> aqiBg = {
    1: Colors.green,
    2: Colors.greenAccent,
    3: Colors.orangeAccent,
    4: Colors.redAccent,
    5: Colors.red,
  };

  final List<AirGuideData> dataList = [
    AirGuideData(
      "Good",
      "1",
      "0-50",
      "0-25",
      "0-60",
      "0-15",
    ),
    AirGuideData(
      "Fair",
      "2",
      "50-100",
      "25-50",
      "60-120",
      "15-30",
    ),
    AirGuideData(
      "Moderate	",
      "3",
      "100-200",
      "50-90",
      "120-180",
      "30-55",
    ),
    AirGuideData(
      "Poor	",
      "4",
      "200-400	",
      "200-400	",
      "180-240",
      "55-110",
    ),
    AirGuideData(
      "Very Poor		",
      "5",
      ">400",
      ">180",
      ">240",
      ">110",
    ),
  ];

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                future: dataAirFuture,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasError) {
                    print("Snapshot Error : ${snapshot.error}");
                  }
                  if (snapshot.hasData) {
                    print("SNAPSHOT HAS DATA");
                    final airData = snapshot.data as AirQualityData;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: airData.list.length,
                      itemBuilder: (context, index) {
                        final a = airData.list[index].main.aqi;
                        final c = airData.list[index].components;
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 24),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: aqiBg[a]!.withOpacity(0.8),
                                  border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey.withOpacity(0.4))),
                              child: Text(
                                " AIR QUALITY INDEX (AQI) : $a",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 32.0),
                              ),
                            ),
                            // Text("AIR INDEX : $a"),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GasContainer(
                                  title: gasNames["co"]!,
                                  value: c.co,
                                ),
                                GasContainer(
                                  title: gasNames["no"]!,
                                  value: c.no,
                                ),
                                GasContainer(
                                  title: gasNames["no2"]!,
                                  value: c.no2,
                                ),
                                GasContainer(
                                  title: gasNames["pm2_5"]!,
                                  value: c.pm2_5,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GasContainer(
                                  title: gasNames["pm10"]!,
                                  value: c.pm10,
                                ),
                                GasContainer(
                                  title: gasNames["o3"]!,
                                  value: c.o3,
                                ),
                                GasContainer(
                                  title: gasNames["so2"]!,
                                  value: c.so2,
                                ),
                                GasContainer(
                                  title: gasNames["nh3"]!,
                                  value: c.nh3,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 44, vertical: 32),
                child: const Divider(
                  color: Colors.white70,
                  height: 0.2,
                ),
              ),
              DataTable(
                dataRowHeight: 32.0,
                dividerThickness: 0.6,
                headingRowColor: MaterialStateProperty.all(Colors.transparent),
                dataRowColor: MaterialStateProperty.all(Colors.transparent),
                columns: [
                  "Sr. No.",
                  "Qualitative name",
                  "NO2 (μg/m3)",
                  "PM10 (μg/m3)",
                  "O3 (μg/m3)",
                  "PM25 (μg/m3)"
                ]
                    .map((e) => DataColumn(
                            label: Container(
                          color: Colors.transparent,
                          child: Text(
                            e,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        )))
                    .toList(),
                rows: dataList
                    .map((air) => DataRow(cells: [
                          DataCell(
                            Text(
                              air.index,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataCell(
                            Text(
                              air.qualitativeName,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataCell(
                            Text(
                              air.NO2,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataCell(
                            Text(
                              air.PM10,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataCell(
                            Text(
                              air.O3,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          DataCell(
                            Text(
                              air.PM25,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GasContainer extends StatelessWidget {
  final String title;
  final double value;

  const GasContainer({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String valueStr = value.toString() + " μg/m3";
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.blueAccent.withOpacity(0.4),
          border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
                color: Colors.white70,
                fontWeight: FontWeight.w400,
                fontSize: 16.0),
          ),
          // style:  GoogleFonts.(
          //     color: Colors.orangeAccent,
          //     fontWeight: FontWeight.w800,
          //     fontSize: 16.0),

          const SizedBox(
            height: 8,
          ),
          Text(
            valueStr,
            style: const TextStyle(
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w800,
                fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}

class AirGuideData {
  String qualitativeName;

  String index;
  String NO2;
  String PM10;
  String O3;

  String PM25;

  AirGuideData(this.qualitativeName, this.index, this.NO2, this.PM10, this.O3,
      this.PM25);
}
