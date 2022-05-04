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
      "RED",
      "YELLOW",
      "BLACK",
      "CYAN",
      "BLUE",
      "GREY",
    ];

    final List<Widget> images = [
      Container(
        color: Colors.red,
      ),
      Container(
        color: Colors.yellow,
      ),
      Container(
        color: Colors.black,
      ),
      Container(
        color: Colors.cyan,
      ),
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.grey,
      ),
    ];

    String readRepositories = """query{me{email}}""";

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Query(
              options: QueryOptions(
                document: gql(readRepositories),
                // this is the query string you just created
                variables: {
                  'nRepositories': 50,
                }
              ),
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
                  return const Text('No repositories');
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
                        color: Colors.white, fontWeight: FontWeight.bold),
                    // optional
                    onPageChanged: (page) {
                      // optional
                    },
                    onSelectedItem: (index) {
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
