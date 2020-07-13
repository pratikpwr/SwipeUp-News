import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/categorynews_screen.dart';
import 'package:flutter_app/Screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  IconData icon;
  String title;
  String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
        radius: 1,
        // colors: [const Color(0xff121212) ,const Color(0xff121212), ],
        colors: [
          const Color(0xff80deea),
          const Color(0xff03a9f4),
        ],
        //center: Alignment(-0.3, -0.2)
      )),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 100, bottom: 100, left: 20, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'SwipeUp',
                  style: GoogleFonts.pacifico(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'News',
                  style: GoogleFonts.pacifico(
                      color: Colors.blue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildCategories(Icons.business, 'Business', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryNewsScreen(category: 'business')));
                }),
                SizedBox(
                  height: 20,
                ),
                buildCategories(Icons.live_tv, 'Entertainment', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryNewsScreen(category: 'entertainment')));
                }),
                SizedBox(
                  height: 20,
                ),
                buildCategories(Icons.spa, 'Health', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryNewsScreen(category: 'health')));
                }),
                SizedBox(
                  height: 20,
                ),
                buildCategories(Icons.directions_run, 'Sport', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryNewsScreen(category: 'sport')));
                }),
                SizedBox(
                  height: 20,
                ),
                buildCategories(Icons.computer, 'Technology', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryNewsScreen(category: 'technology')));
                }),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            buildCategories(Icons.settings, 'Settings', () {})
          ],
        ),
      ),
    );
  }

  Widget buildCategories(IconData icon, String title, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: const Color(0xfff5f5f5),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: GoogleFonts.ptSans(
                color: const Color(0xfff5f5f5),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
