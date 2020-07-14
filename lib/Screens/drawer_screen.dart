import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/home_screen.dart';
import 'package:flutter_app/custom_routes.dart';
import 'package:flutter_app/models/configuration.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx < 0) {
            //Left Swipe
            Navigator.pop(context);
          }
        },
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'DashBoard',
                    style: GoogleFonts.ptSans(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  IconButton(icon: Icon(Icons.settings), onPressed: () {})
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
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
              height: 15,
            ),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newsSource.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: 150,
                    child: Image.network(
                      newsSource[index]['imageUrl'],
                      height: 100,
                      width: 150,
                      fit: BoxFit.cover,
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
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CategoryCard(
                          category: categories[0]['category'],
                          imageUrl: categories[0]['imageUrl'],
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideFromRightPageRoute(
                                    widget: HomeScreen(
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
                                          category: categories[1]
                                              ['category'])));
                            })
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        CategoryCard(
                          category: categories[2]['category'],
                          imageUrl: categories[2]['imageUrl'],
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideFromRightPageRoute(
                                    widget: HomeScreen(
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
                                        category: categories[3]['category'])));
                          },
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        CategoryCard(
                          category: categories[4]['category'],
                          imageUrl: categories[4]['imageUrl'],
                          onTap: () {
                            Navigator.push(
                                context,
                                SlideFromRightPageRoute(
                                    widget: HomeScreen(
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
                                        category: categories[5]['category'])));
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
                height: 100,
                width: MediaQuery.of(context).size.width / 2.1),
            Text(category[0].toUpperCase() + category.substring(1),
                style: GoogleFonts.ptSans(fontSize: 18, color: Colors.blue))
          ],
        ),
      ),
    );
  }
}
