import 'package:booksharing/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

class FlavorConfig {
  final Flavor flavor;
  static FlavorConfig _instance;

  factory FlavorConfig({
    @required Flavor flavor,
    Color color: Colors.blue,
  }) {
    _instance ??= FlavorConfig._internal(flavor);
    return _instance;
  }

  FlavorConfig._internal(this.flavor);
  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProduction() => _instance.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance.flavor == Flavor.DEV;
  static bool isQA() => _instance.flavor == Flavor.QA;
}
