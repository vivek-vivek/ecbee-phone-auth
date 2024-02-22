import 'dart:convert';

class UserModel {
  String id;
  final int generatedNumber;
  final String userId;
  final DateTime dateTime;
  final String ip;
  final String address;

  UserModel({
    required this.id,
    required this.generatedNumber,
    required this.userId,
    required this.dateTime,
    required this.ip,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
