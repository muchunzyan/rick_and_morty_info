import 'package:rick_and_morty_info/classes/character.dart';

class CharactersListWithInfo {
  final int count;
  final int numberOfPages;
  final String prevPageLink;
  final String nextPageLink;
  final List<Character> results;

  const CharactersListWithInfo({
    required this.count,
    required this.numberOfPages,
    required this.prevPageLink,
    required this.nextPageLink,
    required this.results,
  });

  factory CharactersListWithInfo.fromJson(Map<String, dynamic> json) {
    List<Character> charactersList = [];
    for (int i = 0; i < json['results'].length; i++) {
      charactersList.add(Character(
        id: json['results'][i]['id'],
        name: json['results'][i]['name'],
        status: json['results'][i]['status'],
        species: json['results'][i]['species'],
        gender: json['results'][i]['gender'],
        imageLink: json['results'][i]['image'],
      ));
    }

    return CharactersListWithInfo(
      count: json['info']['count'],
      numberOfPages: json['info']['pages'],
      prevPageLink: (json['info']['prev'] != null) ? json['info']['prev'] : "",
      nextPageLink: (json['info']['next'] != null) ? json['info']['next'] : "",
      results: charactersList,
    );
  }
}
