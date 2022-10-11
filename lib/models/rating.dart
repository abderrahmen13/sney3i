class Rating {
  int? id;
  String? userId;
  String? rating;
  String? proffessionnelId;

  Rating({this.id, this.userId, this.rating, this.proffessionnelId});

  factory Rating.fromJson(json) => Rating(
      id: json['id'],
      userId: json['user_id'],
      rating: json['rating'],
      proffessionnelId: json['proffessionnel_id']);

  toJson() => {
        'id': id,
        'rating': rating,
        'user_id': userId,
        'proffessionnel_id': proffessionnelId,
      };

  @override
  String toString() {
    return "id: $id , rating: $rating";
  }
}
