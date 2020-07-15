import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/drawer_screen.dart';
import 'package:flutter_app/Screens/news_detailed_screen.dart';
import 'package:flutter_app/custom_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, sourceName, url , category , heading , publishedAt;


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
    return formattedDay+" | "+ formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          // Right Swipe
          Navigator.push(
              context,
              SlideFromLeftPageRoute(widget: DrawerScreen())
             );
        } else if (details.delta.dx < 0 ) {
          //Left Swipe
          Navigator.push(context, SlideFromRightPageRoute(widget: NewsDetailedScreen(newsUrl: url,)) );
        }
      },
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: imageUrl,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                color: const Color(0xffffffff),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        heading[0].toUpperCase() + heading.substring(1),
                        style: GoogleFonts.spectralSc(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        publishedTime(publishedAt),
                        style: GoogleFonts.ptSans(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          Container(
            height: MediaQuery.of(context).size.height- 400,
            padding: const EdgeInsets.symmetric(horizontal: 20 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      sourceName,
                      style: GoogleFonts.ptSans(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: GoogleFonts.spectralSc(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF080b10),
                          height: 0.95),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(desc,
                        maxLines: 7,
                        style: GoogleFonts.ptSans(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                            color: const Color(0xFF7e808b))),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Swipe left for detailed News' , style: GoogleFonts.ptSans(color: Colors.grey , fontSize: 12 ))
              ],
            ),
          ),

        ],
      ),
    );
  }
}
