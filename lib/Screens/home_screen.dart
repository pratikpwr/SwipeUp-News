import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/news_detailed_screen.dart';
import 'package:flutter_app/Widget/news_tile.dart';
import 'package:flutter_app/models/article_model.dart';
import 'package:flutter_app/helper/news.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArticleModel> articles = new List<ArticleModel>();

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;

    setState(() {
      isLoading = false;
    });
  }



  @override
  //home screen widget
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 1) {
          // Right Swipe
          setState(() {
            xOffset = 230;
            yOffset = 120;
            scaleFactor = 0.75;
            isDrawerOpen = true;
          });
        } else if (details.delta.dx < -1) {
          //Left Swipe
          if (isDrawerOpen == true) {
            setState(() {
              xOffset = 0;
              yOffset = 0;
              scaleFactor = 1;
              isDrawerOpen = false;
            });
          }
          /* else  {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewsDetailedScreen()));
          }*/
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 220),
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return NewsTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        sourceName: articles[index].sourceName,
                        isDrawerOpen: isDrawerOpen,
                        url: articles[index].url,
                      );
                    },
                  ),

      ),
    );
  }
}
