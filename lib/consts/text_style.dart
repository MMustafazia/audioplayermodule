import 'package:audioplayer/consts/colors.dart';
import 'package:flutter/material.dart';

const bold = "omnivaBold.otf";
const regular = "omniva.otf";
ourStyle({family = "omniva.otf", double? size = 14, color = whiteColor}) {
  return TextStyle(
    fontSize: size,
    color: color,
    fontFamily: family,
  );
}
