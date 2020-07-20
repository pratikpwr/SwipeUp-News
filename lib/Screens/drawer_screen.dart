import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/home_screen.dart';
import 'package:flutter_app/custom_routes.dart';
import 'package:flutter_app/models/configuration.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      // backgroundColor: Theme.of(context).accentColor,
      resizeToAvoidBottomPadding: false,
      body: SwipeGestureRecognizer(
        onSwipeLeft: (){
          Navigator.pop(context);
        },
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    'SwipeUp',
                    style: GoogleFonts.spectralSc(
                        color: const Color(0xff26374D),
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
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
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
              height: 5,
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newsSource.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
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
                        child: Image.network(
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
              height: 15,
            ),
            Text(
              'Categories',
              style: GoogleFonts.ptSans(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CategoryCard(
                      category: categories[0]['category'],
                      imageUrl: categories[0]['imageUrl'],
                      onTap: () {
                        Navigator.push(
                            context,
                            SlideFromRightPageRoute(
                                widget: HomeScreen(
                                    title: categories[0]['category'],
                                    category: categories[0]['category'])));
                      },
                    ),
                    CategoryCard(
                        category: categories[1]['category'],
                        imageUrl: categories[1]['imageUrl'],
                        onTap: () {
                          Navigator.push(
                              context,
                              SlideFromRightPageRoute(
                                  widget: HomeScreen(
                                      title: categories[1]['category'],
                                      category: categories[1]
                                          ['category'])));
                        })
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CategoryCard(
                      category: categories[2]['category'],
                      imageUrl: categories[2]['imageUrl'],
                      onTap: () {
                        Navigator.push(
                            context,
                            SlideFromRightPageRoute(
                                widget: HomeScreen(
                                    title: categories[2]['category'],
                                    category: categories[2]['category'])));
                      },
                    ),
                    CategoryCard(
                      category: categories[3]['category'],
                      imageUrl: categories[3]['imageUrl'],
                      onTap: () {
                        Navigator.push(
                            context,
                            SlideFromRightPageRoute(
                                widget: HomeScreen(
                                    title: categories[3]['category'],
                                    category: categories[3]['category'])));
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CategoryCard(
                      category: categories[4]['category'],
                      imageUrl: categories[4]['imageUrl'],
                      onTap: () {
                        Navigator.push(
                            context,
                            SlideFromRightPageRoute(
                                widget: HomeScreen(
                                    title: categories[4]['category'],
                                    category: categories[4]['category'])));
                      },
                    ),
                    CategoryCard(
                      category: categories[5]['category'],
                      imageUrl: categories[5]['imageUrl'],
                      onTap: () {
                        Navigator.push(
                            context,
                            SlideFromRightPageRoute(
                                widget: HomeScreen(
                                    title: categories[5]['category'],
                                    category: categories[5]['category'])));
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
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
            Image.network(imageUrl,
                fit: BoxFit.cover,
                height: 90,
                width: MediaQuery.of(context).size.width / 2.3,),
            Text(category[0].toUpperCase() + category.substring(1),
                style: GoogleFonts.ptSans(fontSize: 18, color: Colors.blue))
          ],
        ),
      ),
    );
  }
}
