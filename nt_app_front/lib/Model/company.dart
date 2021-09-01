// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  Company({
    this.symbol,
    this.companyName,
    this.exchange,
    this.industry,
    this.website,
    this.description,
    this.ceo,
    this.securityName,
    this.issueType,
    this.sector,
    this.primarySicCode,
    this.employees,
    this.tags,
    this.address,
    this.address2,
    this.state,
    this.city,
    this.zip,
    this.country,
    this.phone,
  });

  String? symbol;
  String? companyName;
  String? exchange;
  String? industry;
  String? website;
  String? description;
  String? ceo;
  String? securityName;
  String? issueType;
  String? sector;
  int? primarySicCode;
  int? employees;
  List<String>? tags;
  String? address;
  dynamic address2;
  String? state;
  String? city;
  String? zip;
  String? country;
  String? phone;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        symbol: json["symbol"] == null ? null : json["symbol"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        exchange: json["exchange"] == null ? null : json["exchange"],
        industry: json["industry"] == null ? null : json["industry"],
        website: json["website"] == null ? null : json["website"],
        description: json["description"] == null ? null : json["description"],
        ceo: json["CEO"] == null ? null : json["CEO"],
        securityName:
            json["securityName"] == null ? null : json["securityName"],
        issueType: json["issueType"] == null ? null : json["issueType"],
        sector: json["sector"] == null ? null : json["sector"],
        primarySicCode:
            json["primarySicCode"] == null ? null : json["primarySicCode"],
        employees: json["employees"] == null ? null : json["employees"],
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        address: json["address"] == null ? null : json["address"],
        address2: json["address2"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        zip: json["zip"] == null ? null : json["zip"],
        country: json["country"] == null ? null : json["country"],
        phone: json["phone"] == null ? null : json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol == null ? null : symbol,
        "companyName": companyName == null ? null : companyName,
        "exchange": exchange == null ? null : exchange,
        "industry": industry == null ? null : industry,
        "website": website == null ? null : website,
        "description": description == null ? null : description,
        "CEO": ceo == null ? null : ceo,
        "securityName": securityName == null ? null : securityName,
        "issueType": issueType == null ? null : issueType,
        "sector": sector == null ? null : sector,
        "primarySicCode": primarySicCode == null ? null : primarySicCode,
        "employees": employees == null ? null : employees,
        "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
        "address": address == null ? null : address,
        "address2": address2,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "zip": zip == null ? null : zip,
        "country": country == null ? null : country,
        "phone": phone == null ? null : phone,
      };
}
