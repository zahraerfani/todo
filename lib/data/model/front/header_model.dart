import 'package:flutter/material.dart';

/// title : ""
/// icon : [{"name":"","hasBadge":""}]

class HeaderModel {
  HeaderModel({
    this.title,
    this.icon,
  });

  HeaderModel.fromJson(dynamic json) {
    title = json['title'];
    if (json['icon'] != null) {
      icon = [];
      json['icon'].forEach((v) {
        icon?.add(IconsHeader.fromJson(v));
      });
    }
  }
  String? title;
  List<IconsHeader>? icon;
  HeaderModel copyWith({
    String? title,
    List<IconsHeader>? icon,
  }) =>
      HeaderModel(
        title: title ?? this.title,
        icon: icon ?? this.icon,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    if (icon != null) {
      map['icon'] = icon?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// name : ""
/// hasBadge : ""

class IconsHeader {
  IconsHeader({
    this.name,
    this.hasBadge,
  });

  IconsHeader.fromJson(dynamic json) {
    name = json['name'];
    hasBadge = json['hasBadge'];
  }
  IconData? name;
  bool? hasBadge;
  IconsHeader copyWith({
    IconData? name,
    bool? hasBadge,
  }) =>
      IconsHeader(
        name: name ?? this.name,
        hasBadge: hasBadge ?? this.hasBadge,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['hasBadge'] = hasBadge;
    return map;
  }
}
