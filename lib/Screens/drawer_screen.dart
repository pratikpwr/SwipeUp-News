import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Screens/home_screen.dart';
import '../custom_routes.dart';
import '../models/configuration.dart';
import '../models/theme_changer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String searchedWord;
  List<Map> sources = newsSource;

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeChanger>(context);
    var _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Theme.of(context).accentColor,
      resizeToAvoidBottomPadding: false,

      body: SwipeGestureRecognizer(
        onSwipeLeft: () {
          Navigator.pop(context);
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(
                      15, MediaQuery.of(context).padding.top + 10, 12, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Text('SwipeUp',
                              style: GoogleFonts.spectralSc(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                          Text(
                            'News',
                            style: GoogleFonts.spectralSc(
                                color: Colors.blue,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 1.3,
                        child: Switch(
                            activeColor: Colors.white70,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            activeThumbImage: ExactAssetImage(
                                'assets/moonIcon.png',
                                scale: 2),
                            inactiveThumbImage:
                                ExactAssetImage('assets/sunIcon.png'),
                            value: theme.getTheme(),
                            onChanged: (value) {
                              theme.changeTheme(value);
                            }),
                      ),
                    ],
                  )),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: TextField(
                  autocorrect: true,
                  textInputAction: TextInputAction.search,
                  style: GoogleFonts.ptSans(fontSize: 16),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: (text) {
                    searchedWord = text;
                    Navigator.push(
                        context,
                        SlideFromRightPageRoute(
                            widget: HomeScreen(
                          title: searchedWord,
                          searchedNews: searchedWord,
                        )));
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'News Sources',
                style: GoogleFonts.ptSans(fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: _screenHeight * 0.13,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newsSource.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              SlideFromRightPageRoute(
                                  widget: HomeScreen(
                                title: newsSource[index]['title'],
                                domain: newsSource[index]['web'],
                              )));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            newsSource[index]['imageUrl'],
                            height: 100,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Categories',
                style: GoogleFonts.ptSans(fontSize: 18),
              ),
              Container(
                height: _screenHeight * 0.55,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 5),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                          category: categories[index]['category'],
                          imageUrl: categories[index]['imageUrl'],
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideFromRightPageRoute(
                                    widget: HomeScreen(
                                        title: categories[index]['category'],
                                        category: categories[index]
                                            ['category'])));
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final Function onTap;

  CategoryCard({this.category, this.imageUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8,
        child: Column(
          children: <Widget>[
            Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.11,
              width: MediaQuery.of(context).size.width,
            ),
            Text(category[0].toUpperCase() + category.substring(1),
                style: GoogleFonts.ptSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue))
          ],
        ),
      ),
    );
  }
}

/*void scheduleAlarm() async {
  DateTime scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 10));

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'alarm_notif',
    'alarm_notif',
    'Channel for Alarm notification',
    icon: 'ic_launcher',
    sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
    largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
  );

  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.schedule(
      0,
      'Office',
      'Good morning! Time for office.',
      scheduledNotificationDateTime,
      platformChannelSpecifics);
}*/
