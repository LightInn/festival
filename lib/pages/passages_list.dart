import 'package:festival/models/Festival.model.dart';
import 'package:festival/models/Stand.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PassagesList extends StatefulWidget {
  final Stand stand;

  const PassagesList(this.stand, {Key? key}) : super(key: key);

  @override
  _PassagesListState createState() => _PassagesListState();
}

class _PassagesListState extends State<PassagesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.stand.attributes!.passages!.length,
      itemBuilder: (BuildContext context, int index) {
        if (widget.stand.attributes!.passages!.isEmpty) {
          return Text("Il n'y a pas de stands");
        } else {
          final passage = widget.stand.attributes!.passages![index];
          return Column(
            children: [
              Text(DateFormat('yyyy-MM-dd   kk:mm')
                      .format(passage.attributes!.start ?? DateTime.now()) +
                  " ->"),
              Container(
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
                        Text(passage.attributes!.artiste!.attributes!.name ??
                            "passage"),
                        SizedBox(width: 30.0),
                        GestureDetector(
                          child: RaisedButton(
                              color: Colors.blue,
                              onPressed: () => {},
                              child: Text("programation",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ))),
                        ),
                        SizedBox(width: 10.0),
                      ],
                    )),
              ),
              Text("<-  " +
                  DateFormat('yyyy-MM-dd   kk:mm')
                      .format(passage.attributes!.end ?? DateTime.now())),
            ],
          );
        }
      },
    );
  }
}
