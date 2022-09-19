import 'package:flutter/material.dart';
import 'package:rick_and_morty_info/classes/episodes_list_with_info.dart';
import 'package:rick_and_morty_info/http_requests.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({Key? key}) : super(key: key);

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  late Future<EpisodesListWithInfo> futureEpisodesListWithInfo;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    futureEpisodesListWithInfo =
        fetchEpisodesListWithInfo('https://rickandmortyapi.com/api/episode');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EpisodesListWithInfo>(
        future: futureEpisodesListWithInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              controller: _controller,
              itemCount: snapshot.data!.results.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index < snapshot.data!.results.length) {
                  return Card(
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 3 - 24,
                        height: MediaQuery.of(context).size.width * 1 / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ListTile(
                              title: Text(snapshot.data!.results[index].name),
                            ),
                            ListTile(
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      "Specie: ${snapshot.data!.results[index].airDate}"),
                                  Text(
                                      "Gender: ${snapshot.data!.results[index].episode}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        (snapshot.data!.prevPageLink != "")
                            ? SizedBox(
                          width: (snapshot.data!.nextPageLink != "")
                              ? MediaQuery.of(context).size.width / 3
                              : MediaQuery.of(context).size.width - 16,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              onNavigationBtnPress(snapshot, "prev");
                            },
                            child: const Text("Previous page"),
                          ),
                        )
                            : const SizedBox.shrink(),
                        (snapshot.data!.nextPageLink != "")
                            ? SizedBox(
                          width: (snapshot.data!.prevPageLink != "")
                              ? MediaQuery.of(context).size.width / 3
                              : MediaQuery.of(context).size.width - 16,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              onNavigationBtnPress(snapshot, "next");
                            },
                            child: const Text("Next page"),
                          ),
                        )
                            : const SizedBox.shrink(),
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
        futureEpisodesListWithInfo = fetchEpisodesListWithInfo(
            (direction == "prev")
                ? snapshot.data!.prevPageLink
                : snapshot.data!.nextPageLink);
      }
    });
    _scrollUp();
  }

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
