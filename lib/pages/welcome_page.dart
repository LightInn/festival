import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../utils/graphql_request.dart';
import '../utils/jwt_token.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Query(
              options: QueryOptions(
                  fetchPolicy: FetchPolicy.cacheAndNetwork,
                  document: gql(GraphqlRequest().me)),
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return const Text('Loading');
                }

                log(result.data.toString());

                if (result.data?["me"]?["role"]?["name"] == "Admin") {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          JwtToken().deleteToken();
                          Navigator.of(context).pushNamed("/login");
                        },
                        child: Text(
                            result.data?['me']?['email'].toString() ?? "test"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/admin");
                          },
                          child: const Text("Admin panel"))
                    ],
                  );
                } else {
                  return TextButton(
                    onPressed: () {
                      JwtToken().deleteToken();
                      Navigator.of(context).pushNamed("/login");
                    },
                    child:
                        Text(result.data?['me']?['email'].toString() ?? "test"),
                  );
                }
              },
            ),
            Expanded(
              child: Container(
                child: Query(
                  options: QueryOptions(
                      fetchPolicy: FetchPolicy.cacheAndNetwork,
                      document: gql(GraphqlRequest().publicData)),
                  builder: (QueryResult result,
                      {VoidCallback? refetch, FetchMore? fetchMore}) {
                    if (result.hasException) {
                      return Text(result.exception.toString());
                    }

                    if (result.isLoading) {
                      return const Text('Loading');
                    }

                    log(result.data.toString());

                    if (result.data?["festivals"]?["data"] != null) {
                      var festivalList = result.data?["festivals"]?["data"];

                      var festivalNames = festivalList
                          .map((i) => i["attributes"]?["name"].toString())
                          .toList();

                      List<String> festivalNamesList =
                          new List<String>.from(festivalNames);

                      List<Widget> festivalWidgetsList = festivalList
                          .map<Widget>((i) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                decoration: BoxDecoration(
                                    color: Color((math.Random().nextDouble() *
                                                0xFFFFFF)
                                            .toInt())
                                        .withOpacity(1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Text(
                                    i["attributes"]?["name"].toString() ??
                                        "name"),
                              ))
                          .toList();

                      return VerticalCardPager(
                          titles: festivalNamesList,
                          // required
                          images: festivalWidgetsList,
                          // required
                          textStyle: const TextStyle(
                              fontSize: 1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          // optional
                          onPageChanged: (page) {
                            // optional
                          },
                          onSelectedItem: (index) {
                            Navigator.of(context).pushNamed("/register");

                            // optional
                          },
                          initialPage: festivalNamesList.length,
                          // optional
                          align: ALIGN.CENTER // optional
                          );
                    } else {
                      return Text("no data");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
