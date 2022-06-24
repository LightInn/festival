import 'dart:collection';

import 'package:flutter/material.dart';

import 'festival_detail_page.dart';

class PassagesDetailPage extends StatefulWidget {
  final String passageId;
  final dynamic ArtistesList;

  const PassagesDetailPage({
    Key? key,
    required this.passageId,
    required this.ArtistesList,
  }) : super(key: key);

  @override
  _PassagesDetailPageState createState() => _PassagesDetailPageState();
}

class _PassagesDetailPageState extends State<PassagesDetailPage> {
  @override
  Widget build(BuildContext context) {
    late List<dynamic> ArtistesList;

    if (widget.ArtistesList.isEmpty) {
      return const Scaffold(
          backgroundColor: Colors.white, body: Center(child: Text("pas d\'artiste")));
    } else {
      if (widget.ArtistesList?[0] == null) {
        ArtistesList = [widget.ArtistesList];
      } else {
        ArtistesList = widget.ArtistesList;
      }

      return Scaffold(
        body: Container(
            child: ListView.builder(
                itemCount: ArtistesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(ArtistesList[index]?['attributes']?['name']
                            .toString() ??
                        "name"),
                    subtitle: Text(ArtistesList[index]?['attributes']
                                ?['description']
                            .toString() ??
                        "description"),
                  );
                })),
      );
    }
  }
}
