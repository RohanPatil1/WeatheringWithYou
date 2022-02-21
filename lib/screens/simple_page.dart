import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:weathering_you/data/bloc/weather_handler_bloc.dart';

import '../constant.dart';

class SimplePage extends StatefulWidget {
  const SimplePage({Key? key}) : super(key: key);

  @override
  _SimplePageState createState() => _SimplePageState();
}

class _SimplePageState extends State<SimplePage> {
  WeatherFactory wf = WeatherFactory(OPEN_WEATHER_API);
  String dateString = "";
  Future? dataFuture;
  final d = DateTime.now();

  Future<Weather> getDataByCity(String city) async {
    Weather w = await wf.currentWeatherByCityName(city);

    return w;
  }

  Future<Weather> getDataByLatLng() async {
    Weather w = await wf.currentWeatherByLocation(
        WeatherBloc().currentLat, WeatherBloc().currentLong);

    return w;
  }

  @override
  void initState() {
    // TODO: implement initState

    dateString =
        "${days[d.weekday - 1]}, ${d.day.toString()} ${d.year.toString()}";

    dataFuture = getDataByCity("Mumbai");
    // WeatherBloc().fetchCurrentLocation().then((value) {
    //   dataFuture = getDataByLatLng();
    //   setState(() {});
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: TextFormField(
              onFieldSubmitted: (value) {
                dataFuture = getDataByCity(value);
                WeatherBloc().onLocationSearch(value);
                setState(() {});
              },
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18.0, color: Colors.white),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: "Type city name",
                alignLabelWithHint: true,
                hoverColor: Colors.teal,
                hintStyle: GoogleFonts.architectsDaughter(
                  fontSize: 18.0,
                  color: Colors.white60,
                ),
                filled: true,
                fillColor: Colors.black38,
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: dataFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              final w = snapshot.data as Weather;

              final iconUrl =
                  "http://openweathermap.org/img/w/${w.weatherIcon}.png";
              final temp = w.temperature.toString().substring(0, 2) + " °C";
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${w.areaName}, ${w.country} ",
                      style:
                          const TextStyle(fontSize: 72.0, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      dateString,
                      style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.orangeAccent.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 44.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white.withOpacity(0.3)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            iconUrl,
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "${w.weatherMain}",
                            style: GoogleFonts.montserrat(
                                fontSize: 54.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            temp,
                            style: const TextStyle(
                                fontSize: 84.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
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
    );
  }
}
