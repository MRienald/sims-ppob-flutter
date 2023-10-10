import 'dart:convert';

class Balance {
    int? balance;

    Balance({
        this.balance,
    });

    factory Balance.fromRawJson(String str) => Balance.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Balance.fromJson(Map<String, dynamic> json) => Balance(
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
    };
}
