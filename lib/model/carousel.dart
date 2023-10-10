import 'dart:convert';

class Carousel {
    String? bannerName;
    String? bannerImage;
    String? description;

    Carousel({
        this.bannerName,
        this.bannerImage,
        this.description,
    });

    factory Carousel.fromRawJson(String str) => Carousel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Carousel.fromJson(Map<String, dynamic> json) => Carousel(
        bannerName: json["banner_name"],
        bannerImage: json["banner_image"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "banner_name": bannerName,
        "banner_image": bannerImage,
        "description": description,
    };
}
