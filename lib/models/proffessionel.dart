import 'package:snay3i/models/rating.dart';

class Proffessionel {
  int? id;
  String? uid;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? cin;
  String? image;
  String? adress;
  String? picture;
  String? birthday;
  String? phone;
  String? status;
  Rating? rating;
  String? sms;
  String? calls;

  Proffessionel({
    this.id,
    this.uid,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.cin,
    this.image,
    this.adress,
    this.picture,
    this.birthday,
    this.phone,
    this.status,
    this.rating,
    this.sms,
    this.calls,
  });

  factory Proffessionel.fromJson(json) => Proffessionel(
      id: json['id'],
      uid: json['uid'],
      firstname: json['first_name'],
      lastname: json['last_name'],
      email: json['email'],
      cin: json['cin'],
      image: json['image'],
      adress: json['adress'],
      birthday: json['birthday'],
      phone: json['phone'],
      picture: json['picture'],
      status: json['status'],
      sms: json['sms'],
      calls: json['calls']);

  toJson() => {
        'id': id,
        'uid': uid,
        'first_name': firstname,
        'last_name': lastname,
        'email': email,
        'cin': cin,
        'image': image,
        'adress': adress,
        'birthday': birthday,
        'phone': phone,
        'picture': picture,
        'status': status,
        'sms': sms,
        'calls': calls
      };

  @override
  String toString() {
    return "id: $id name: $firstname email: $email ";
  }
}
