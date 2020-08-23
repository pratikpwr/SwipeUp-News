import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';
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
      body: SwipeGestureRecognizer(
        onSwipeRight: () {
          Navigator.pop(context);
        },
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Text(
                  'SwipeUp',
                  style: GoogleFonts.spectralSc(
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'News',
                  style: GoogleFonts.spectralSc(
                      color: Colors.blue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height - 80,
              width: MediaQuery.of(context).size.width,
              child: WebView(
                initialUrl: widget.newsUrl,
                gestureRecognizers: Set()
                  ..add(Factory<PlatformViewVerticalGestureRecognizer>(
                      () => PlatformViewVerticalGestureRecognizer())),
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: ((WebViewController webViewController) {
                  _controller.complete(webViewController);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// stack overflow solution -- vertical gestures where not working properly so added the below class
//https://stackoverflow.com/questions/57069716/scrolling-priority-when-combining-horizontal-scrolling-with-webview
class PlatformViewVerticalGestureRecognizer
    extends VerticalDragGestureRecognizer {
  PlatformViewVerticalGestureRecognizer({PointerDeviceKind kind})
      : super(kind: kind);

  Offset _dragDistance = Offset.zero;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    _dragDistance = _dragDistance + event.delta;
    if (event is PointerMoveEvent) {
      final double dy = _dragDistance.dy.abs();
      final double dx = _dragDistance.dx.abs();

      if (dy > dx && dy > kTouchSlop) {
        // vertical drag - accept
        resolve(GestureDisposition.accepted);
        _dragDistance = Offset.zero;
      } else if (dx > kTouchSlop && dx > dy) {
        // horizontal drag - stop tracking
        stopTrackingPointer(event.pointer);
        _dragDistance = Offset.zero;
      }
    }
  }

  @override
  String get debugDescription => 'horizontal drag (platform view)';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
