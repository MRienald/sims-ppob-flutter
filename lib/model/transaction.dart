import 'dart:convert';

class Transaction {
    String? invoiceNumber;
    String? serviceCode;
    String? serviceName;
    String? transactionType;
    int? totalAmount;
    DateTime? createdOn;

    Transaction({
        this.invoiceNumber,
        this.serviceCode,
        this.serviceName,
        this.transactionType,
        this.totalAmount,
        this.createdOn,
    });

    factory Transaction.fromRawJson(String str) => Transaction.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        invoiceNumber: json["invoice_number"],
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        transactionType: json["transaction_type"],
        totalAmount: json["total_amount"],
        createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    );

    Map<String, dynamic> toJson() => {
        "invoice_number": invoiceNumber,
        "service_code": serviceCode,
        "service_name": serviceName,
        "transaction_type": transactionType,
        "total_amount": totalAmount,
        "created_on": createdOn?.toIso8601String(),
    };
}
