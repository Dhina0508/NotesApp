import 'dart:convert';

class NotesListModel {
  bool? error;
  List<NotesModel>? data;

  NotesListModel({
    this.error,
    this.data,
  });

  factory NotesListModel.fromRawJson(String str) =>
      NotesListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotesListModel.fromJson(Map<String, dynamic> json) => NotesListModel(
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<NotesModel>.from(
                json["data"]!.map((x) => NotesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotesModel {
  int? id;
  int? userId;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isDeleted;

  NotesModel({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
  });

  factory NotesModel.fromRawJson(String str) =>
      NotesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isDeleted: json["is_deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_deleted": isDeleted,
      };
}
