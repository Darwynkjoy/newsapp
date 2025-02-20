// To parse this JSON data, do
//
//     final newsappApImodel = newsappApImodelFromJson(jsonString);

import 'dart:convert';

NewsappApImodel newsappApImodelFromJson(String str) => NewsappApImodel.fromJson(json.decode(str));


class NewsappApImodel {
    List<Article> articles;

    NewsappApImodel({
        required this.articles,
    });

    factory NewsappApImodel.fromJson(Map<String, dynamic> json) => NewsappApImodel(
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

}

class Article {
    Source source;
    dynamic author;
    String title;
    String description;
    String url;
    String urlToImage;
    DateTime publishedAt;
    String content;

    Article({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );
}

class Source {
    dynamic id;
    String name;

    Source({
        required this.id,
        required this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
    );
}
