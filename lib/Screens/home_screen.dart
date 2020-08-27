import 'package:flutter/material.dart';
import '../Screens/drawer_screen.dart';
import '../Widget/news_tile.dart';
import '../custom_routes.dart';
import '../models/article_model.dart';
import '../helper/news.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final String category;
  final String searchedNews;
  final String domain;
  final String title;

  HomeScreen({this.category, this.domain, this.title, this.searchedNews});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArticleModel> articles = new List<ArticleModel>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews(
        widget.category, widget.searchedNews, widget.domain);
    articles = newsClass.news;

    setState(() {
      isLoading = false;
    });
  }

  //home screen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : articles.length == 0
                ? Center(
                    child: Text(
                      'Error in getting News.',
                      style:
                          GoogleFonts.ptSans(color: Colors.red, fontSize: 26),
                    ),
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
                        url: articles[index].url,
                        publishedAt: articles[index].publishedAt,
                        heading:
                            widget.title == null ? 'TopNews' : widget.title,
                        category: widget.category == null
                            ? 'TopNews'
                            : widget.category,
                      );
                    },
                  ),
        Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(
                      context, SlideFromLeftPageRoute(widget: DrawerScreen()));
                })
          ],
        ),
      ],
    ));
  }
}
