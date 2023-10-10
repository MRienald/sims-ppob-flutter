import 'dart:convert';

class ServiceMenu {
    String? serviceCode;
    String? serviceName;
    String? serviceIcon;
    int? serviceTariff;

    ServiceMenu({
        this.serviceCode,
        this.serviceName,
        this.serviceIcon,
        this.serviceTariff,
    });

    factory ServiceMenu.fromRawJson(String str) => ServiceMenu.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServiceMenu.fromJson(Map<String, dynamic> json) => ServiceMenu(
        serviceCode: json["service_code"],
        serviceName: json["service_name"],
        serviceIcon: json["service_icon"],
        serviceTariff: json["service_tariff"],
    );

    Map<String, dynamic> toJson() => {
        "service_code": serviceCode,
        "service_name": serviceName,
        "service_icon": serviceIcon,
        "service_tariff": serviceTariff,
    };
}
