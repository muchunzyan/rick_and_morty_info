import 'package:rick_and_morty_info/classes/episode.dart';

class EpisodesListWithInfo {
  final int count;
  final int numberOfPages;
  final String prevPageLink;
  final String nextPageLink;
  final List<Episode> results;

  const EpisodesListWithInfo({
    required this.count,
    required this.numberOfPages,
    required this.prevPageLink,
    required this.nextPageLink,
    required this.results,
  });

  factory EpisodesListWithInfo.fromJson(Map<String, dynamic> json) {
    List<Episode> locationsList = [];
    for (int i = 0; i < json['results'].length; i++) {
      locationsList.add(Episode(
        id: json['results'][i]['id'],
        name: json['results'][i]['name'],
        airDate: json['results'][i]['air_date'],
        episode: json['results'][i]['episode'],
      ));
    }

    return EpisodesListWithInfo(
      count: json['info']['count'],
      numberOfPages: json['info']['pages'],
      prevPageLink: (json['info']['prev'] != null) ? json['info']['prev'] : "",
      nextPageLink: (json['info']['next'] != null) ? json['info']['next'] : "",
      results: locationsList,
    );
  }
}
