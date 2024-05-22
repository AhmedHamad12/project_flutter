import 'package:flutter/material.dart';

extension contextExtension on BuildContext{
  double get width => MediaQuery.of(this).size.width;//عرض الشاشة الحالى
  double get height => MediaQuery.of(this).size.height;//طول الشاشة الحالى
}