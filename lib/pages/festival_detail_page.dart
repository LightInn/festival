import 'dart:collection';

import 'package:festival2/pages/stands_detail_page.dart';
import 'package:flutter/material.dart';

class FestivalDetailPage extends StatefulWidget {
  final String festivalId;
  final dynamic StandList;

  const FestivalDetailPage({
    Key? key,
    required this.festivalId,
    required this.StandList,
  }) : super(key: key);

  @override
  _FestivalDetailPageState createState() => _FestivalDetailPageState();
}

class _FestivalDetailPageState extends State<FestivalDetailPage> {
  @override
  Widget build(BuildContext context) {
    late List<dynamic> StandList;

    if (widget.StandList.isEmpty) {
      return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: Text("pas de stand")));
    } else {
      if (widget.StandList?[0] == null) {
        StandList = [widget.StandList];
      } else {
        StandList = widget.StandList;
      }

      return Scaffold(
        body: Container(
            child: ListView.builder(
                itemCount: StandList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StandsDetailPage(
                            standId: StandList[index]['id'],
                            PassageList: StandList[index]?['attributes']
                                ?['passages']?['data'],
                          ),
                        ),
                      );
                    },
                    title: Text(
                        StandList[index]?['attributes']?['name'].toString() ??
                            "name"),
                    subtitle: Text(StandList[index]?['attributes']?['position']
                            .toString() ??
                        "position"),
                  );
                })),
      );
    }
  }
}
