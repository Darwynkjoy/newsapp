// To parse this JSON data, do
//
//     final newpaper = newpaperFromJson(jsonString);

import 'dart:convert';

Newpaper newpaperFromJson(String str) => Newpaper.fromJson(json.decode(str));

class Newpaper {
    Source source;
    String author;
    String title;
    String description;
    String url;
    String urlToImage;
    DateTime publishedAt;
    String content;

    Newpaper({
        required this.source,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    factory Newpaper.fromJson(Map<String, dynamic> json) => Newpaper(
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
    String id;
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
