import 'dart:convert';

class MusicModel {
  final String imageUrl;
  final String name;
  final String artist;
  final String lyrics;

  MusicModel({
    required this.imageUrl,
    required this.name,
    required this.artist,
    required this.lyrics,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'artist': artist,
      'lyrics': lyrics,
    };
  }

  factory MusicModel.fromMap(Map<String, dynamic> map) {
    return MusicModel(
      imageUrl: map['imageUrl'],
      name: map['name'],
      artist: map['artist'],
      lyrics: map['lyrics'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicModel.fromJson(String source) => MusicModel.fromMap(json.decode(source));
}
