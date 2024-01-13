import 'dart:convert';

UserInteraction userInteractionFromJson(String str) => UserInteraction.fromJson(json.decode(str));

String userInteractionToJson(UserInteraction data) => json.encode(data.toJson());

class UserInteraction {
    final String interactionId;
    final String lng;
    final DateTime datetimePrint;
    final double datetimeSql;
    final String lat;
    final Interaction interaction;
    final String type;

    UserInteraction({
        required this.interactionId,
        required this.lng,
        required this.datetimePrint,
        required this.datetimeSql,
        required this.lat,
        required this.interaction,
        required this.type,
    });

    factory UserInteraction.fromJson(Map<String, dynamic> json) => UserInteraction(
        interactionId: json["InteractionID"],
        lng: json["lng"],
        datetimePrint: DateTime.parse(json["datetime_print"]),
        datetimeSql: json["datetime_sql"]?.toDouble(),
        lat: json["lat"],
        interaction: Interaction.fromJson(json["Interaction"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "InteractionID": interactionId,
        "lng": lng,
        "datetime_print": datetimePrint.toIso8601String(),
        "datetime_sql": datetimeSql,
        "lat": lat,
        "Interaction": interaction.toJson(),
        "type": type,
    };
}

class Interaction {
    final String status;
    final int nik;
    final String email;
    final String userId;
    final String photo;
    final String name;
    final String password;

    Interaction({
        required this.status,
        required this.nik,
        required this.email,
        required this.userId,
        required this.photo,
        required this.name,
        required this.password,
    });

    factory Interaction.fromJson(Map<String, dynamic> json) => Interaction(
        status: json["Status"],
        nik: json["NIK"],
        email: json["Email"],
        userId: json["UserID"],
        photo: json["Photo"],
        name: json["Name"],
        password: json["Password"],
    );

    Map<String, dynamic> toJson() => {
        "Status": status,
        "NIK": nik,
        "Email": email,
        "UserID": userId,
        "Photo": photo,
        "Name": name,
        "Password": password,
    };
}
