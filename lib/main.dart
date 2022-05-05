import 'package:festival2/pages/register_page.dart';
import 'package:festival2/utils/jwt_token.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'components/splash_screen.dart';
import 'pages/login_page.dart';
import 'pages/welcome_page.dart';

Future<void> main() async {
  await initHiveForFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
      'https://festival.brev.al/graphql/',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => await JwtToken().getToken(),
    );

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Festival',
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        // todo : Mettre SplashScreen
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext) => LoginPage(
                title: 'Login',
              ),
          '/register': (BuildContext) => RegisterPage(title: 'register',),
          '/home': (BuildContext) => WelcomePage(),
          // '/options': (BuildContext) => OptionsCrudPage(),
        },
      ),
    );
  }
}
