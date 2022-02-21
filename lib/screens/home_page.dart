import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/typicons_icons.dart';

import '../constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currTab = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/bg.PNG",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: pages[currTab],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 24.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white.withOpacity(0.3)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Simple Page
                    InkWell(
                      onTap: () {
                        setState(() {
                          currTab = 0;
                        });
                      },
                      child: Icon(Typicons.cloud_sun,
                          color: (currTab == 0) ? Colors.white : Colors.white60,
                          size: 24.0),
                    ),
                    const SizedBox(
                      width: 16,
                    ),

                    //Air Quality
                    InkWell(
                      onTap: () {
                        setState(() {
                          currTab = 1;
                        });
                      },
                      child: Icon(Entypo.air,
                          color: (currTab == 1) ? Colors.white : Colors.white60,
                          size: 24.0),
                    ),
                    const SizedBox(
                      width: 16,
                    ),

                    //EarthQuakes
                    InkWell(
                      onTap: () {
                        setState(() {
                          currTab = 2;
                        });
                      },
                      child: Icon(LineariconsFree.earth,
                          color: (currTab == 2) ? Colors.white : Colors.white60,
                          size: 24.0),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          currTab = 3;
                        });
                      },
                      child: Icon(Icons.timeline,
                          color: (currTab == 3) ? Colors.white : Colors.white60,
                          size: 24.0),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          currTab = 4;
                        });
                      },
                      child: Icon(Typicons.news,
                          color: (currTab == 4) ? Colors.white : Colors.white60,
                          size: 24.0),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
