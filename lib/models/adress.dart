class Adress {
  int? id;
  String? name;

  Adress({
    this.id,
    this.name
  });

  factory Adress.fromJson(json) => Adress(
      id: json['id'],
      name: json['name']);

  toJson() => {
        'id': id,
        'name': name
      };

  @override
  String toString() {
    return "id: $id , name: $name";
  }
}
