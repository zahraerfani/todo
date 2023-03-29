/// name : ""
/// icon : 1
/// color : 2

class SubCategoryModel {
  SubCategoryModel({
    this.name,
    this.icon,
    this.color,
  });

  SubCategoryModel.fromJson(dynamic json) {
    name = json['name'];
    icon = json['icon'];
    color = json['color'];
  }
  String? name;
  int? icon;
  int? color;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['icon'] = icon;
    map['color'] = color;
    return map;
  }
}
