import 'package:flutter/material.dart';
import 'package:rick_and_morty_info/classes/characters_list_with_info.dart';
import 'package:rick_and_morty_info/http_requests.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late Future<CharactersListWithInfo> futureCharactersListWithInfo;

  @override
  void initState() {
    super.initState();
    futureCharactersListWithInfo = fetchCharactersListWithInfo(
        'https://rickandmortyapi.com/api/character');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CharactersListWithInfo>(
        future: futureCharactersListWithInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.results.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index < snapshot.data!.results.length) {
                  return Card(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 2 / 3 - 24,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ListTile(
                                  title:
                                      Text(snapshot.data!.results[index].name),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          "Status: ${snapshot.data!.results[index].status}"),
                                      Text(
                                          "Specie: ${snapshot.data!.results[index].species}"),
                                      Text(
                                          "Gender: ${snapshot.data!.results[index].gender}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 1 / 3,
                              height: MediaQuery.of(context).size.width * 1 / 3,
                              child: Image.network(
                                snapshot.data!.results[index].imageLink,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;

                                  return const Center(
                                      child: CircularProgressIndicator());
                                  // You can use LinearProgressIndicator or CircularProgressIndicator instead
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Text('Some errors occurred!'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              onNavigationBtnPress(snapshot, "prev");
                            },
                            child: const Text("Prev page"),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              onNavigationBtnPress(snapshot, "next");
                            },
                            child: const Text("Next page"),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${snapshot.error}'),
              ],
            ));
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }

  void onNavigationBtnPress(AsyncSnapshot snapshot, String direction) {
    setState(() {
      if (((direction == "prev")
              ? snapshot.data!.prevPageLink
              : snapshot.data!.nextPageLink) !=
          "") {
        futureCharactersListWithInfo = fetchCharactersListWithInfo(
            (direction == "prev")
                ? snapshot.data!.prevPageLink
                : snapshot.data!.nextPageLink);
      }
    });
  }
}
