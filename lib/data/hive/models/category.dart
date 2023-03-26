import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part '../adapters/category.g.dart';

@HiveType(typeId: 3)
class CategoryTask extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final IconData? icon;
  @HiveField(2)
  final Color? color;
  CategoryTask({
    required this.name,
    required this.icon,
    required this.color,
  });
  CategoryTask copyWith({
    String? name,
    IconData? icon,
    Color? color,
  }) {
    return CategoryTask(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryTask &&
        other.name == name &&
        other.icon == icon &&
        other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode ^ color.hashCode;
}
