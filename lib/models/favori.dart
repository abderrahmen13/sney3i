import 'package:snay3i/models/proffessionel.dart';

class Favori {
  int? id;
  String? userId;
  String? proffessionnelId;
  String? createdAt;
  String? updatedAt;
  Proffessionel? person;

  Favori({this.id, this.userId, this.proffessionnelId, this.createdAt, this.updatedAt, this.person});

  factory Favori.fromJson(json) => Favori(
      id: json['id'],
      userId: json['user_id'],
      proffessionnelId: json['proffessionnel_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      person: Proffessionel.fromJson(json['person']));

  toJson() => {
        'id': id,
        'user_id': userId,
        'proffessionnel_id': proffessionnelId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'person': person,
      };

  @override
  String toString() {
    return "id: $id , proffessionnelId: $proffessionnelId";
  }
}
