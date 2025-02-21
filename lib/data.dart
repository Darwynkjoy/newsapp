// To parse this JSON data, do
//
//     final newsappapimodel = newsappapimodelFromJson(jsonString);

import 'dart:convert';

Newsappapimodel newsappapimodelFromJson(String str) => Newsappapimodel.fromJson(json.decode(str));


class Newsappapimodel {
    List<Article> articles;

    Newsappapimodel({
        required this.articles,
    });

    factory Newsappapimodel.fromJson(Map<String, dynamic> json) => Newsappapimodel(
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

}

class Article {
    Source source;
    String author;
    String title;
    String description;
    String url;
    dynamic urlToImage;
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
