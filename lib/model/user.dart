import 'dart:convert';
import 'dart:developer';

class User {
    String? email;
    String? firstName;
    String? lastName;
    String? profileImage;

    User({
        this.email,
        this.firstName,
        this.lastName,
        this.profileImage,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileImage: json["profile_image"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image": profileImage,
    };
}

extension UserExt on User {
  bool validate() {
    log('Validasi User = name is ${firstName != null} ${lastName != null}, '
        'email is ${email != null}');
    return firstName != null &&
        lastName != null &&
        email != null;
  }
}

class UserAccount {
    String? email;
    String? firstName;
    String? lastName;
    String? password;

    UserAccount({
        this.email,
        this.firstName,
        this.lastName,
        this.password,
    });

    factory UserAccount.fromRawJson(String str) => UserAccount.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
    };
}