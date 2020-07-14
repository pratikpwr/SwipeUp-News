import 'package:flutter/material.dart';
import 'package:flutter_app/Widget/news_tile.dart';
import 'package:flutter_app/models/article_model.dart';
import 'package:flutter_app/helper/news.dart';

class HomeScreen extends StatefulWidget {
  final String category;
  HomeScreen({this.category});
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
    await newsClass.getNews(widget.category);
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
                    category: widget.category == null ?'TopNews': widget.category,
                  );
                },
              ));
  }
}
