import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImageBuilder extends StatelessWidget {
  final String imgUrl;

  const ImageBuilder({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      imgUrl,
      (int _) => ImageElement()..src = imgUrl,
    );
    return HtmlElementView(
      viewType: imgUrl,
    );
  }
}
