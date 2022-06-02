import 'package:festival2/pages/admin_panel_page.dart';
import 'package:festival2/pages/crud/artiste/artiste_liste_page.dart';
import 'package:festival2/pages/crud/artiste/artiste_new_page.dart';
import 'package:festival2/pages/crud/festival/festival_edit_page.dart';
import 'package:festival2/pages/crud/festival/festival_liste_page.dart';
import 'package:festival2/pages/crud/festival/festival_new_page.dart';
import 'package:festival2/pages/crud/passage/passage_liste_page.dart';
import 'package:festival2/pages/crud/passage/passage_new_page.dart';
import 'package:festival2/pages/crud/stands/stand_liste_page.dart';
import 'package:festival2/pages/crud/stands/stand_new_page.dart';
import 'package:festival2/pages/register_page.dart';
import 'package:festival2/utils/jwt_token.dart';
import 'package:flutter/material.dart';
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
        defaultPolicies: DefaultPolicies(),
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
          primaryColor: Colors.deepPurpleAccent,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const SplashScreen(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext) => const LoginPage(
                title: 'Login',
              ),
          '/register': (BuildContext) => const RegisterPage(
                title: 'register',
              ),
          '/home': (BuildContext) => const WelcomePage(),

          '/admin': (BuildContext) => const AdminPanelPage(),

          '/festival': (BuildContext) => const FestivalListePage(),
          '/festival/new': (BuildContext) => const FestivalNewPage(),

          '/stand': (BuildContext) => const StandListePage(),
          '/stand/new': (BuildContext) => const StandNewPage(),

          '/passage': (BuildContext) => const PassageListePage(),
          '/passage/new': (BuildContext) => const PassageNewPage(),

          '/artiste': (BuildContext) => const ArtisteListePage(),
          '/artiste/new': (BuildContext) => const ArtisteNewPage(),

          // '/options': (BuildContext) => OptionsCrudPage(),
        },
      ),
    );
  }
}
