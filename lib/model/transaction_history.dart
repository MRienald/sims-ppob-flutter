import 'dart:convert';

class TransactionHistory {
    String? offset;
    String? limit;
    List<Record>? records;

    TransactionHistory({
        this.offset,
        this.limit,
        this.records,
    });

    factory TransactionHistory.fromRawJson(String str) => TransactionHistory.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
        offset: json["offset"],
        limit: json["limit"],
        records: json["records"] == null ? [] : List<Record>.from(json["records"]!.map((x) => Record.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "records": records == null ? [] : List<dynamic>.from(records!.map((x) => x.toJson())),
    };
}

class Record {
    String? invoiceNumber;
    String? transactionType;
    String? description;
    int? totalAmount;
    DateTime? createdOn;

    Record({
        this.invoiceNumber,
        this.transactionType,
        this.description,
        this.totalAmount,
        this.createdOn,
    });

    factory Record.fromRawJson(String str) => Record.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Record.fromJson(Map<String, dynamic> json) => Record(
        invoiceNumber: json["invoice_number"],
        transactionType: json["transaction_type"],
        description: json["description"],
        totalAmount: json["total_amount"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    );

    Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "transaction_type": transactionType,
        "description": description,
        "total_amount": totalAmount,
        "created_on": createdOn?.toIso8601String(),
    };
}
