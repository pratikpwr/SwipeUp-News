import 'package:flutter/material.dart';
import 'package:flutter_app/Widget/news_tile.dart';
import 'package:flutter_app/helper/news.dart';
import 'package:flutter_app/models/article_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryNewsScreen extends StatefulWidget {
  final String category;
  CategoryNewsScreen({this.category});

  @override
  _CategoryNewsScreenState createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  List<ArticleModel> articlesCategory = new List<ArticleModel>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getCategoryNews(widget.category);
    articlesCategory = newsClass.news;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //use back button
      body:isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: articlesCategory.length,
        itemBuilder: (context, index) {
          return NewsTile(
            imageUrl: articlesCategory[index].urlToImage,
            title: articlesCategory[index].title,
            desc: articlesCategory[index].description,
            sourceName: articlesCategory[index].sourceName,
            isDrawerOpen: false,
            url: articlesCategory[index].url,
          );
        },
      ),
    );
  }
}
