import 'dart:convert';

import 'package:flutter_app/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url = category == null
        ? "http://newsapi.org/v2/top-headlines?country=in&pageSize=50&apiKey=088e0a35838e4d6191b27dc049ad7720"
        : "http://newsapi.org/v2/top-headlines?country=in&category=$category&pageSize=50&apiKey=088e0a35838e4d6191b27dc049ad7720";
    /*use &
    q='word u  want to search'
    v2 /top-headlines or /everything
    sources=
    time   from=2020-07-11&to=2020-07-11
    country=us
    category=business
     */
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            sourceName: element["source"]["name"],
            content: element["content"],
            url: element["url"],
            urlToImage: element["urlToImage"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
