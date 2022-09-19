import 'package:rick_and_morty_info/classes/location.dart';

class LocationsListWithInfo {
  final int count;
  final int numberOfPages;
  final String prevPageLink;
  final String nextPageLink;
  final List<Location> results;

  const LocationsListWithInfo({
    required this.count,
    required this.numberOfPages,
    required this.prevPageLink,
    required this.nextPageLink,
    required this.results,
  });

  factory LocationsListWithInfo.fromJson(Map<String, dynamic> json) {
    List<Location> locationsList = [];
    for (int i = 0; i < json['results'].length; i++) {
      locationsList.add(Location(
        id: json['results'][i]['id'],
        name: json['results'][i]['name'],
        type: json['results'][i]['type'],
        dimension: json['results'][i]['dimension'],
      ));
    }

    return LocationsListWithInfo(
      count: json['info']['count'],
      numberOfPages: json['info']['pages'],
      prevPageLink: (json['info']['prev'] != null) ? json['info']['prev'] : "",
      nextPageLink: (json['info']['next'] != null) ? json['info']['next'] : "",
      results: locationsList,
    );
  }
}
