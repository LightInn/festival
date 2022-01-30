import 'dart:developer';
import 'dart:ui';

import 'package:festival/models/Festival.model.dart';
import 'package:festival/pages/stands_list.dart';
import 'package:festival/services/FestivalService.dart';
import 'package:flutter/material.dart';

import 'crud/options_crud_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late int _index = 1;

  @override
  void initState() {
    // _startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Festival"),
          Center(
            child: SizedBox(
              height: 350, // card height
              child: FutureBuilder<List<Festival>>(
                  future: festivalGetAll(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      log("has data");
                      return PageView.builder(
                        itemCount: snapshot.data!.length,
                        controller: PageController(
                            viewportFraction: 0.7, initialPage: _index),
                        onPageChanged: (int index) =>
                            setState(() => _index = index),
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 0.85,
                            child: Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "${snapshot.data![i].attributes!.name}\nDate : du ${snapshot.data![i].attributes!.startDate} au ${snapshot.data![i].attributes!.endDate}\n Emplacement : ${snapshot.data![i].attributes!.location} ",
                                      style: const TextStyle(fontSize: 32),
                                    ),
                                    ElevatedButton(
                                        onPressed: () => {
                                              Navigator.of(context).push(
                                                  _createRoute(
                                                      snapshot.data![i]))
                                            },
                                        child: Text("Acceder"))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
          ),
          ElevatedButton(
              onPressed: () =>
                  {Navigator.of(context).pushReplacementNamed("/options")},
              child: Text("Options")),
        ],
      ),
    );
  }
}

Route _createRoute(Festival festival) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        StandsList(festival),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Widget _buildCarouselItem(
    BuildContext context, int carouselIndex, int itemIndex) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ),
  );
}

// _buildCarousel(int carouselIndex) {
//   return ;
// }