import 'dart:collection';

import 'package:festival2/pages/passages_detail_page.dart';
import 'package:flutter/material.dart';

import 'festival_detail_page.dart';

class StandsDetailPage extends StatefulWidget {
  final String standId;
  final dynamic PassageList;

  const StandsDetailPage({
    Key? key,
    required this.standId,
    required this.PassageList,
  }) : super(key: key);

  @override
  _StandsDetailPageState createState() => _StandsDetailPageState();
}

class _StandsDetailPageState extends State<StandsDetailPage> {
  @override
  Widget build(BuildContext context) {
    late List<dynamic> PassageList;

    if (widget.PassageList.isEmpty ) {
      return const Scaffold(
          backgroundColor: Colors.white, body: Center(child: Text("pas de passages")));
    } else {
      if (widget.PassageList?[0] == null) {
        PassageList = [widget.PassageList];
      } else {
        PassageList = widget.PassageList;
      }

      return Scaffold(
        body: Container(
            child: ListView.builder(
                itemCount: PassageList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PassagesDetailPage(
                            passageId: PassageList[index]['id'],
                            ArtistesList: PassageList[index]?['attributes']
                                ?['artist']?['data'],
                          ),
                        ),
                      );
                    },
                    title: Text(PassageList[index]?['attributes']?['date_start']
                            .toString() ??
                        "name"),
                    subtitle: Text(PassageList[index]?['attributes']
                                ?['duration']
                            .toString() ??
                        "position"),
                  );
                })),
      );
    }
  }
}
