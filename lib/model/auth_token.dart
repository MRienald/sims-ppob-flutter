import 'dart:convert';

class AuthToken {
    String? token;

    AuthToken({
        this.token,
    });

    factory AuthToken.fromRawJson(String str) => AuthToken.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
    };
}
