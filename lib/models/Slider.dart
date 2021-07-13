// To parse this JSON data, do
//
//     final slider = sliderFromJson(jsonString);

import 'dart:convert';

List<Sliders> sliderFromJson(String str) => List<Sliders>.from(json.decode(str).map((x) => Sliders.fromJson(x)));

String sliderToJson(List<Sliders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sliders {
    Sliders({
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

    factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
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
