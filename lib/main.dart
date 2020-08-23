import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/theme_changer.dart';
import 'package:provider/provider.dart';
import './Screens/home_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  //print('initScreen $initScreen');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
        create: (context) => ThemeChanger(false), child: new ThemeApply());
  }
}

class ThemeApply extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'SwipeUpNews',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme() ? ThemeData.dark() : ThemeData.light(),
      initialRoute: initScreen == 0 || initScreen == null ? "intro" : "/",
      routes: {
        '/': (context) => HomeScreen(),
        "intro": (context) => IntroScreen(),
      },
    );
  }
}

/*class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      /*gradientBackground: RadialGradient(radius: 1, colors: [
        const Color(0xff80deea),
        const Color(0xff03a9f4),
      ]),*/
      image: Image.asset('assets/swipeUp.png'),
      loaderColor: Colors.white,
      photoSize: 150,
      navigateAfterSeconds: IntroScreen(),
    );
  }
}*/

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  SwiperController _controller = SwiperController();
  int _currentIndex = 0;
  final List<String> text = [
    'Swipe Up for More News',
    'Swipe Left for Detailed News',
    'Swipe Right for DashBoard'
  ];
  final List<String> imageUrl = [
    'assets/upss.jpg',
    'assets/upleft.jpg',
    'assets/upright.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Swiper(
            loop: false,
            index: _currentIndex,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: 3,
            pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                    activeSize: 15, color: Colors.grey)),
            itemBuilder: (context, index) {
              return IntroItem(
                text: text[index],
                imageUrl: imageUrl[index],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
                child: Text('Skip')),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: _currentIndex == 2
                ? FlatButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    },
                    child: Text('Done'))
                : FlatButton(
                    onPressed: () {
                      _controller.next();
                    },
                    child: Text('Swipe')),
          )
        ],
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  final String text;
  final String imageUrl;

  IntroItem({this.text, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Column(
        children: <Widget>[
          Image.asset(
            'assets/swipeUp.png',
            height: 150,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Image.asset(imageUrl),
          SizedBox(
            height: 40,
          ),
          Text(
            text,
            style: GoogleFonts.ptSans(fontSize: 20),
          ),
        ],
      )),
    );
  }
}
