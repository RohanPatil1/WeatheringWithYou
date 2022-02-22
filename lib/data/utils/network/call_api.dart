import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'is_connected.dart';

Future<dynamic> postCallApi(Map<String, dynamic> body, String apiUrl) async {
  bool isConnected = await isNetworkConnected();
  print("===========");
  print("IsConnected : $isConnected");
  late http.Response response;
  if (!isConnected) return {'success': false};

  final String url = 'https://dapabackend.herokuapp.com/api/$apiUrl';
  // const String url = 'http://localhost:8080/api/getAllUsers';
  try {
    response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
  } on HttpException {
    print("Couldn't find the post 😱");

    return null;
  } on SocketException catch (e) {
    print(
        'No Internet connection 😑  ${e.message}  also ${e.address}  also ${e.osError}');

    return null;
  } on FormatException {
    print("Bad response format 👎");

    return null;
  } on Exception catch (_, e) {
    print(e.toString());

    return null;
  }

  print("===RESPOONSE==");
  print(response.body);
  //No Internet connection 😑    also InternetAddress('23.22.130.173', IPv4)  also OS Error: Connection timed out, errno = 110
  //No Internet connection 😑    also InternetAddress('107.22.57.98', IPv4)  also OS Error: Connection timed out, errno = 110
  return json.decode(response.body);
}

Future<dynamic> getCallApi(String url) async {
  bool isConnected = await isNetworkConnected();

  late http.Response response;
  if (!isConnected) return "No Internet Connection";

  try {
    response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      debugPrint(data);
      return json.decode(response.body);
    }
  } on HttpException {
    print("Couldn't find the post 😱");

    return "Couldn't find the post";
  } on SocketException catch (e) {
    print(
        'No Internet connection 😑  ${e.message}  also ${e.address}  also ${e.osError}');

    return "No Internet connection";
  } on FormatException {
    print("Bad response format 👎");

    return "Bad response format ";
  } on Exception catch (_, e) {
    print(e.toString());
    return e.toString();
  }

  return json.decode(response.body);
}
