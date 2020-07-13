import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/drawer_screen.dart';
import 'package:flutter_app/Screens/home_screen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwipeUpNews',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          canvasColor: const Color(0xFFefefef),
          accentColor: const Color(0xFF325b88),
          /*
          title text  = const Color(0xFF080b10)
          description text = const Color(0xFF7e808b)
         */
          textTheme: TextTheme(
            headline6: TextStyle(
                fontFamily: 'PTSansCaption',
                color: const Color(0xFF080b10),
                fontSize: 26),
          )),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      gradientBackground: RadialGradient(
          radius: 1,
          colors: [ const Color(0xff80deea),const Color(0xff03a9f4),]),
      image: Image.asset('assets/swipe.png'),
      loaderColor: Colors.white,
      photoSize: 150,
      navigateAfterSeconds: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
