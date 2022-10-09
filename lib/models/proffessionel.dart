class Proffessionel {
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

  Proffessionel({
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
  });

  factory Proffessionel.fromJson(json) => Proffessionel(
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
      status: json['status']);

  toJson() => {
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
        'status': status
      };

  @override
  String toString() {
    return "name: $firstname email: $email ";
  }
}
