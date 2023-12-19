// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    final String email;
    final int nik;
    final String name;
    final String password;
    final int phone;
    final String photo;
    final String status;
    final String tagid;
    final String userId;

    User({
        required this.email,
        required this.nik,
        required this.name,
        required this.password,
        required this.phone,
        required this.photo,
        required this.status,
        required this.tagid,
        required this.userId,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["Email"],
        nik: json["NIK"],
        name: json["Name"],
        password: json["Password"],
        phone: json["Phone"],
        photo: json["Photo"],
        status: json["Status"],
        tagid: json["Tagid"],
        userId: json["UserID"],
    );

    Map<String, dynamic> toJson() => {
        "Email": email,
        "NIK": nik,
        "Name": name,
        "Password": password,
        "Phone": phone,
        "Photo": photo,
        "Status": status,
        "Tagid": tagid,
        "UserID": userId,
    };
}
