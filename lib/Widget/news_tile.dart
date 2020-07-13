import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/news_detailed_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTile extends StatelessWidget {
  final String imageUrl, title, desc, sourceName, url;
  final bool isDrawerOpen;

  NewsTile(
      {this.imageUrl,
      this.title,
      this.desc,
      this.sourceName,
      this.isDrawerOpen,
      this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx < -1) {
          //left wipe
          if (isDrawerOpen == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsDetailedScreen(
                          newsUrl: url,
                        )));
          }
        }
      },
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isDrawerOpen ? 40 : 0)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Container(
            color: const Color(0xffffffff),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '#TopNews',
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
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF080b10),
                      height: 1),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(desc,
                    style: GoogleFonts.ptSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF7e808b)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
