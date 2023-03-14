import 'package:flutter/material.dart';

myShadows({Color? color, double? blur, Offset? offset}) {
  return BoxShadow(
    blurRadius: blur ?? 5,
    offset: offset ?? const Offset(0, 1),
    color: color ?? Colors.grey.withOpacity(0.5),
  );
}
