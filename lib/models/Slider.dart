// To parse this JSON data, do
//
//     final slider = sliderFromJson(jsonString);

import 'dart:convert';

List<Slider> sliderFromJson(String str) => List<Slider>.from(json.decode(str).map((x) => Slider.fromJson(x)));

String sliderToJson(List<Slider> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Slider {
    Slider({
        this.albumId,
        this.id,
        this.title,
        this.url,
        this.thumbnailUrl,
    });

    int albumId;
    int id;
    String title;
    String url;
    String thumbnailUrl;

    factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
    );

    Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
    };
}
