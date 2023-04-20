// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
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

    String email;
    String nik;
    String name;
    String password;
    String phone;
    String photo;
    String status;
    String tagid;
    String userId;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
