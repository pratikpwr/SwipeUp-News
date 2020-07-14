import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/drawer_screen.dart';
import 'package:flutter_app/Screens/news_detailed_screen.dart';
import 'package:flutter_app/custom_routes.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, sourceName, url , category;


  NewsTile(
      {this.imageUrl,
      this.title,
      this.desc,
      this.sourceName,
      this.url,
      this.category});

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    category[0].toUpperCase() + category.substring(1),
                    style: GoogleFonts.ptSans(
                        fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "Monday at 05:30 AM",
                    style: GoogleFonts.ptSans(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  sourceName,
                  style: GoogleFonts.ptSans(fontSize: 14),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  title,
                  style: GoogleFonts.grenze(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF080b10),
                      height: 1),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(desc,
                    style: GoogleFonts.ptSans(
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                        color: const Color(0xFF7e808b))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
