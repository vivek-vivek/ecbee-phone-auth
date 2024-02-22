import 'dart:convert';

class UsersModel {
  String? id;
  final int? generatedNumber;
  final String? userId;
  // final DateTime dateTime;
  final String? ip;
  final String? address;

  UsersModel({
    this.id,
    this.generatedNumber,
    this.userId,
    //  this.dateTime,
    this.ip,
    this.address,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        generatedNumber: json['generatedNumber'],
        userId: json['userId'] as String,
        // dateTime: DateTime.parse(json['dateTime'].toString()),
        ip: json['ip'] as String,
        address: json['address'] as String,
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'generatedNumber': generatedNumber,
        'userId': userId,
        // 'dateTime': dateTime.toIso8601String(),
        'ip': ip,
        'address': address,
        'id': id,
      };
}
