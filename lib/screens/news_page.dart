import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:weathering_you/data/bloc/weather_handler_bloc.dart';

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
        child: Stack(
          children: [
            FutureBuilder(
              future: dataNewsFuture,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                print(
                    "snapshot.connectionState.index ${snapshot.connectionState.index}");
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: WeatherBloc().newsData.articles.length,
                    itemBuilder: (context, index) {
                      final article = WeatherBloc().newsData.articles[index];
                      return Text(article.title);
                    },
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
