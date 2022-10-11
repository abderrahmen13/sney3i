class Category {
  int? id;
  String? name;
  String? icon;
  List<Category>? subCategoryItems;

  Category({
    this.id,
    this.name,
    this.icon,
    this.subCategoryItems,
  });

  factory Category.fromJson(json) => Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      subCategoryItems: (json['sub_category_items'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e))
          .toList());

  toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
        'sub_category_items': subCategoryItems
      };

  @override
  String toString() {
    return "id: $id , name: $name";
  }
}
