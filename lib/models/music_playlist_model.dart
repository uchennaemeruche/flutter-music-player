import 'package:flutter/material.dart';

class MusicPlaylist{
  final IconData musicIcon;
  final String musicTitle;
  final String artist;
  final List categoryIds;
  final String duration;
  final bool isFavourite;

  MusicPlaylist({this.musicIcon, this.musicTitle, this.artist, this.categoryIds, this.duration, this.isFavourite});
}

List<MusicPlaylist> playlists = [
  MusicPlaylist(
    musicIcon: Icons.library_music,
    musicTitle: "Far Away Forest",
    artist: "Mother Eart Sounds",
    categoryIds: [0,1],
    duration: "1:24",
    isFavourite: true,
  ),
  MusicPlaylist(
    musicIcon: Icons.queue_music,
    musicTitle: "Electric Relaxation",
    artist: "Mother Eart Sounds",
    categoryIds: [0,2],
    duration: "2:24",
    isFavourite: true,
  ),
  MusicPlaylist(
    musicIcon: Icons.person_pin,
    musicTitle: "Mirage",
    artist: "Else",
    categoryIds: [0,2],
    duration: "3:24",
    isFavourite: false,
  ),
  MusicPlaylist(
    musicIcon: Icons.pages,
    musicTitle: "Worry About Us",
    artist: "Rose Lowe",
    categoryIds: [0,2],
    duration: "4:21",
    isFavourite: false,
  ),
];