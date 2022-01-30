import 'dart:developer';

import 'package:festival/models/Festival.model.dart';
import 'package:festival/models/Stand.model.dart';
import 'package:festival/pages/passages_list.dart';
import 'package:flutter/material.dart';

class StandsList extends StatefulWidget {
  final Festival festival;

  const StandsList(this.festival, {Key? key}) : super(key: key);

  @override
  _StandsListState createState() => _StandsListState();
}

class _StandsListState extends State<StandsList> {
  @override
  Widget build(BuildContext context) {
    log(widget.festival.attributes!.stand.toString());

    return ListView.builder(
      itemCount: widget.festival.attributes!.stand!.length,
      itemBuilder: (BuildContext context, int index) {
        if (widget.festival.attributes!.stand!.isEmpty) {
          return Text("Il n'y a pas de stands");
        } else {
          final stand = widget.festival.attributes!.stand![index];
          return Container(
            margin: EdgeInsets.only(left: 35.0, top: 5.0, bottom: 5.0),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                elevation: 15.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FractionalTranslation(
                      translation: Offset(-0.4, 0.0),
                      child: Align(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://en.wikipedia.org/wiki/Fest_Noz#/media/File:Startijenn_-_Festival_Yaouank_2015_-_35.jpg"),
                          radius: 40.0,
                        ),
                        alignment: FractionalOffset(0.5, 0.0),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(stand.attributes!.name ?? "festival"),
                    SizedBox(width: 30.0),
                    GestureDetector(
                      child: ElevatedButton(
                          onPressed: () =>
                              {Navigator.of(context).push(_createRoute(stand))},
                          child: Text("programation",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ))),
                    ),
                    SizedBox(width: 10.0),
                  ],
                )),
          );
        }
      },
    );
  }

  Route _createRoute(Stand stand) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PassagesList(stand),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
