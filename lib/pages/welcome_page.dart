import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

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

    String readRepositories = """query{me{email}}""";

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Query(
              options: QueryOptions(document: gql(readRepositories),
                  // this is the query string you just created
                  variables: {
                    'nRepositories': 50,
                  }),
              // Just like in apollo refetch() could be used to manually trigger a refetch
              // while fetchMore() can be used for pagination purpose
              builder: (QueryResult result,
                  {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return const Text('Loading');
                }

                List? repositories =
                    result.data?['viewer']?['repositories']?['nodes'];

                if (repositories == null) {
                  return Text(
                      result.data?['me']?['email'].toString() ?? "test");
                }

                return ListView.builder(
                    itemCount: repositories.length,
                    itemBuilder: (context, index) {
                      final repository = repositories[index];

                      return Text(repository['name'] ?? '');
                    });
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
                        color: Colors.white, fontWeight: FontWeight.bold),
                    // optional
                    onPageChanged: (page) {
                      // optional
                    },
                    onSelectedItem: (index) {
                      Navigator.of(context).pushNamed("/register");

                      // optional
                    },
                    initialPage: 0,
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
