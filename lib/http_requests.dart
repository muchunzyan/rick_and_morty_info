import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_info/classes/characters_list_with_info.dart';
import 'package:rick_and_morty_info/classes/locations_list_with_info.dart';

Future<CharactersListWithInfo> fetchCharactersListWithInfo(String link) async {
  final response = await http.get(Uri.parse(link));

  if (response.statusCode == 200) {
    return CharactersListWithInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load characters');
  }
}

Future<LocationsListWithInfo> fetchLocationsListWithInfo(String link) async {
  final response = await http.get(Uri.parse(link));

  if (response.statusCode == 200) {
    return LocationsListWithInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load characters');
  }
}
