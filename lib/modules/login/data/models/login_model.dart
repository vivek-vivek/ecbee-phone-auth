import 'dart:convert';

class LoginModel {
  String id;
  final int generatedNumber;
  final String userId;
  final DateTime dateTime;
  final String ip;
  final String address;

  LoginModel({
    required this.id,
    required this.generatedNumber,
    required this.userId,
    required this.dateTime,
    required this.ip,
    required this.address,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        generatedNumber: json['generatedNumber'] as int,
        userId: json['userId'] as String,
        dateTime: DateTime.parse(json['dateTime'] as String),
        ip: json['ip'] as String,
        address: json['address'] as String,
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'generatedNumber': generatedNumber,
        'userId': userId,
        'dateTime': dateTime.toIso8601String(),
        'ip': ip,
        'address': address,
        'id': id,
      };
}
