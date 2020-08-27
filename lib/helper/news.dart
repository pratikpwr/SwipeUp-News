import 'dart:convert';
import '../key/keys.dart';
import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  //String apiKey = '088e0a35838e4d6191b27dc049ad7720';
  Future<void> getNews(String category , String searchedNews , String domain ) async {

    String link (String category , String searchedNews , String domain){
      if(category == null && searchedNews== null && domain == null){
        return "http://newsapi.org/v2/top-headlines?country=in&pageSize=100&apiKey=$apiKey";
      }
      else if( searchedNews== null && domain == null){
        return "http://newsapi.org/v2/top-headlines?country=in&category=$category&pageSize=100&apiKey=$apiKey";
      }
      else if(category == null && searchedNews== null ){
        return "https://newsapi.org/v2/everything?domains=$domain&sortBy=publishedAt&pageSize=100&apiKey=$apiKey";
      }
      else if(category == null && domain== null){
        return "https://newsapi.org/v2/everything?q=$searchedNews&sortBy=publishedAt&pageSize=100&apiKey=$apiKey";
      }
      else{
        return null;
      }
    }

    String url = link(category ,  searchedNews ,  domain);
    /*use &
    q='word u  want to search'
    v2 /top-headlines or /everything
    domains=  .com
    language=hi en
    time   from=2020-07-11&to=2020-07-11
    country=us
    category=business
     */
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"].toString().length > 80) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            description: element["description"],
            sourceName: element["source"]["name"],
            content: element["content"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            publishedAt: element["publishedAt"]
          );
          news.add(articleModel);
        }
      });
    }
  }
}
