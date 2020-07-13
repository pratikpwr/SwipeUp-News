import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailedScreen extends StatefulWidget {
  final String newsUrl;

  NewsDetailedScreen({this.newsUrl});

  @override
  _NewsDetailedScreenState createState() => _NewsDetailedScreenState();
}

class _NewsDetailedScreenState extends State<NewsDetailedScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              'SwipeUp',
              style: GoogleFonts.pacifico(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'News',
              style: GoogleFonts.pacifico(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.newsUrl,
          gestureRecognizers: Set()
            ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: ((WebViewController webViewController) {
            _controller.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
