import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:weathering_you/data/bloc/weather_handler_bloc.dart';
import 'package:weathering_you/widgets/web_image_builder.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future? dataNewsFuture;

  @override
  void initState() {
    dataNewsFuture = WeatherBloc().fetchNewsData(context);
    // setState(() {});
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
        child: FutureBuilder(
          future: dataNewsFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              print("SNAPSHOT ERROR ${snapshot.error}");
            }
            print(
                "snapshot.connectionState.index ${snapshot.connectionState.index}");
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: WeatherBloc().newsData.articles.length,
                itemBuilder: (context, index) {
                  final article = WeatherBloc().newsData.articles[index];
                  print("URL ${article.urlToImage}");
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 400,
                            width: MediaQuery.of(context).size.width - 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: ImageBuilder(
                                imgUrl: article.urlToImage ??
                                    "https://images.indianexpress.com/2022/02/Nodal-JaishankarPTI-3col.jpg",
                              ),
                            ),
                          ),
                          Container(
                            height: 400,
                            width: MediaQuery.of(context).size.width - 100,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                  Colors.black,
                                  Colors.transparent,
                                ])),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Positioned(
                            left: 0,
                            bottom: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Marquee(
                                      text: article.title,
                                      style: const TextStyle(
                                          fontSize: 32.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800),
                                      // style: const TextStyle(
                                      //     fontSize: 14.0, color: Colors.white70,fontWeight: FontWeight.w200),
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // blankSpace: 20.0,
                                      velocity: 32.0,
                                      // pauseAfterRound: Duration(seconds: 1),
                                      startPadding: 10.0,
                                      // accelerationDuration: Duration(seconds: 1),
                                      // accelerationCurve: Curves.linear,
                                      // decelerationDuration: Duration(milliseconds: 500),
                                      // decelerationCurve: Curves.easeOut,
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Text(
                                  //     article.title,
                                  //     style: const TextStyle(
                                  //         fontSize: 32.0,
                                  //         color: Colors.white,
                                  //         fontWeight: FontWeight.w800),
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 8.0,
                                  // ),

                                  Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Marquee(
                                      text: article.description ??
                                          "India, officially the Republic of India, is a country in South Asia. It is the seventh-largest country by area, the second-most populous country, and the most populous democracy in the world.",
                                      style: GoogleFonts.montserrat(
                                        // fontWeight: FontWeight.w300,
                                        fontSize: 14.0,
                                        color: Colors.white70,
                                      ),
                                      // style: const TextStyle(
                                      //     fontSize: 14.0, color: Colors.white70,fontWeight: FontWeight.w200),
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // blankSpace: 20.0,
                                      velocity: 64.0,
                                      // pauseAfterRound: Duration(seconds: 1),
                                      startPadding: 10.0,
                                      // accelerationDuration: Duration(seconds: 1),
                                      // accelerationCurve: Curves.linear,
                                      // decelerationDuration: Duration(milliseconds: 500),
                                      // decelerationCurve: Curves.easeOut,
                                    ),
                                  ),
                                  // Text(
                                  //   article.description,
                                  //   style: const TextStyle(
                                  //       fontSize: 14.0, color: Colors.white70,fontWeight: FontWeight.w200),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 24),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.grey.withOpacity(0.4),
                                  border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey.withOpacity(0.4))),
                              child: Text(
                                "${article.source.name} • ${article.publishedAt} ",
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 12.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
