import 'package:flutter/material.dart';
import 'package:flutter_app/Widget/news_tile.dart';
import 'package:flutter_app/models/article_model.dart';
import 'package:flutter_app/helper/news.dart';

class HomeScreen extends StatefulWidget {
  final String category;
  final String searchedNews;
  final String domain;
  final String title;

  HomeScreen({this.category, this.domain , this.title, this.searchedNews});
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
    await newsClass.getNews(widget.category , widget.searchedNews , widget.domain);
    articles = newsClass.news;

    setState(() {
      isLoading = false;
    });
  }

  //home screen widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
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
                    url: articles[index].url,
                    publishedAt: articles[index].publishedAt,
                    heading: widget.title== null ? 'TopNews': widget.title,
                    category:  widget.category== null ? 'TopNews': widget.category,
                  );
                },
              ));
  }
}
