import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todos_app/colors.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 5,
    errorMethodCount: 15,
  ),
);

Color getRandomColor() {
  return CustomColors.colors[Random().nextInt(CustomColors.colors.length)];
}
