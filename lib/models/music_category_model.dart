import 'package:flutter/material.dart';
import 'package:flutter_music_player/commons/colors.dart';

class MusicCategory{
  final int categoryId;
  final String categoryName;
  final IconData categoryIcon;
  final Color categoryColor;
  final bool isLandscape;

  MusicCategory({this.categoryId, this.categoryName, this.categoryIcon, this.categoryColor, this.isLandscape});
}

List<MusicCategory> categories = [
  MusicCategory(
    categoryId:1,
    categoryName: "Ambient",
    categoryIcon: Icons.flash_on,
    categoryColor: blueColor,
    isLandscape: false,
  ),
  MusicCategory(
    categoryId:2,
    categoryName: "Hip Hop",
    categoryIcon: Icons.blur_circular,
    categoryColor: greenColor,
    isLandscape: true,
  ),
  MusicCategory(
    categoryId:3,
    categoryName: "High Life",
    categoryIcon: Icons.lightbulb_outline,
    categoryColor: darkColor,
    isLandscape: true,
  ),
  MusicCategory(
    categoryId:0,
    categoryName: "All",
    categoryIcon: Icons.all_inclusive,
    categoryColor: blueColor,
    isLandscape: true,
  ),
];