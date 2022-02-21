import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weathering_you/screens/air_quality_page.dart';
import 'package:weathering_you/screens/earthquake_page.dart';
import 'package:weathering_you/screens/forecast_page.dart';
import 'package:weathering_you/screens/news_page.dart';
import 'package:weathering_you/screens/simple_page.dart';

const OPEN_WEATHER_API = "551bceb1825daa3ff74a9f59e7c076b6";
const NEWS_API = "3c306b27306041a2a1b8564dd048044c";

final months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];
final days = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
];

// Architects+Daughter

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey(); // Create a key

const Color foregroundColor = Colors.white;
const Color backgroundColor = Color(0xffF3F3F3);
const Color activeColor = Color(0xff834DF3);
const Color textColor = Color(0xff645D6E);
const Color purpleBgColor = Color(0xffDAC7FF);
const Color redBgColor = Color(0xffFCCFCF);
const Color redActiveColor = Color(0xffEA5455);
const Color greenBgColor = Color(0xffE0F9EE);
const Color greenActiveColor = Color(0xff11D47B);
const Color yellowBgColor = Color(0xffFFE5C6);
const Color yellowActiveColor = Color(0xffFF9B26);

const List<Color> activeTabGradient = [
  Color(0xff834DF3),
  Color(0xff996CF5),
];
const Color textDarkGrey = Color(0xff4B4B4B);
const Color textLightGrey = Color(0xffACA8B5);
const Color textColor2 = Color(0xff70697B);

const Color colorComb11 = Colors.deepPurple;
const Color colorComb12 = Colors.greenAccent;
const Color colorComb13 = Colors.pinkAccent;

const Color colorComb21 = Colors.blue;
const Color colorComb22 = Colors.deepOrange;
const Color colorComb23 = Colors.orangeAccent;

const commonTextStyle = TextStyle(color: Colors.white, fontSize: 14.0);

double getDoubleRandomV() {
  double randomDouble = Random().nextDouble();
  return randomDouble;
}

List<Widget> pages = const [
  SimplePage(),
  AirQualityPage(),
  EarthquakesPage(),
  ForecastPage(),
  NewsPage(),
];
