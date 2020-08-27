import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Screens/drawer_screen.dart';
import '../Screens/news_detailed_screen.dart';
import '../custom_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swipe_gesture_recognizer/swipe_gesture_recognizer.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl,
      title,
      desc,
      sourceName,
      url,
      category,
      heading,
      publishedAt;

  NewsTile(
      {this.imageUrl,
      this.title,
      this.heading,
      this.desc,
      this.publishedAt,
      this.sourceName,
      this.url,
      this.category});

  String publishedTime(String strDate) {
    DateTime newsDate = DateTime.parse(strDate);
    //return formatDate(newsDate, [h,':',m,]);
    String formattedDay = new DateFormat.MMMEd().format(newsDate);
    String formattedTime = new DateFormat.jm().format(newsDate);
    return formattedDay + " | " + formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    //var screenWidth = MediaQuery.of(context).size.width;
    //var curScaleFactor = MediaQuery.of(context).textScaleFactor;
    return SwipeGestureRecognizer(
      onSwipeLeft: () {
        Navigator.push(
            context,
            SlideFromRightPageRoute(
                widget: NewsDetailedScreen(
              newsUrl: url,
            )));
      },
      onSwipeRight: () {
        Navigator.push(context, SlideFromLeftPageRoute(widget: DrawerScreen()));
      },
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: imageUrl,
                height: screenHeight * 0.5,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: screenHeight * 0.04,
                //color: const Color(0xffffffff),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        heading[0].toUpperCase() + heading.substring(1),
                        style: GoogleFonts.spectralSc(
                            fontSize: 16 , fontWeight: FontWeight.w800),
                      ),
                      Text(
                        publishedTime(publishedAt ?? 'Today'),
                        style: GoogleFonts.ptSans(
                            fontSize: 14 , fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: screenHeight * 0.46,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Divider(
                      height: 2,
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      sourceName ?? 'Sources',
                      style: GoogleFonts.ptSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                          fontSize: 16 ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      title ?? 'Read Detailed News',
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spectralSc(
                          fontSize: 20 ,
                          fontWeight: FontWeight.bold,
                          height: 0.95),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(desc ?? 'Read Detailed News',
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ptSans(
                            fontSize: 16 ,
                            //fontWeight: FontWeight.bold,
                            color: const Color(0xFF7e808b))),
                  ],
                ),
                Text('Swipe left for detailed News',
                    style: GoogleFonts.ptSans(
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                        fontSize: 12 ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
