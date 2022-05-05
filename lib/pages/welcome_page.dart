import 'dart:developer';

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
    final List<String> titles = [
      "Festival de Canne",
      "Le festival Tomorrowland",
      "Le festival Rock",
      "Le festival Coachellas",
      "Burning Man",
      "Pitchfork Music Festival",
    ];

    final List<Widget> images = [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Query(
              options: QueryOptions(
                fetchPolicy: FetchPolicy.cacheAndNetwork,
                document: gql(GraphqlRequest().me)
              ),
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

                          }, child: Text("Admin panel"))
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
                child: VerticalCardPager(
                    titles: titles,
                    // required
                    images: images,
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
                    initialPage: titles.length,
                    // optional
                    align: ALIGN.CENTER // optional
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
