import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../../utils/graphql_request.dart';
import 'passage_liste_page.dart';

class PassageEditPage extends StatefulWidget {
  final int id;
  final String dateDebut;
  final int duration;
  final int stand;
  final int artist;

  const PassageEditPage(
      {Key? key,
      required this.id,
      required this.dateDebut,
      required this.duration,
      required this.stand,
      required this.artist})
      : super(key: key);

  @override
  _PassageEditPageState createState() => _PassageEditPageState();
}

class _PassageEditPageState extends State<PassageEditPage> {

  late DateTime dateDebut;
  late TextEditingController durationController;
  late int standValue;
  late int artistValue;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    dateDebut = DateTime.parse(widget.dateDebut);

    durationController = TextEditingController(text: widget.duration.toString());
    standValue = widget.stand;
    artistValue = widget.artist;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 14),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: Color(0xFF090F13),
                            size: 30,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                  child: Text(
                    'Créer un Festival',
                    style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF090F13),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [],
          elevation: 0,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      'Date de debut du passage : ',
                    ),
                  ),
                  Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      child: OutlinedButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1900, 3, 5),
                                maxTime: DateTime(2100, 6, 7),
                                onChanged: (date) {
                                  dateDebut = date;
                                  print('change $date');
                                }, onConfirm: (date) {
                                  setState(() {
                                    dateDebut = date;
                                    print('confirm $date');
                                  });
                                },
                                currentTime: dateDebut,
                                locale: LocaleType.fr);
                          },
                          child: Text(
                            '${dateDebut.day.toString()}/${dateDebut.month.toString()}/${dateDebut.year.toString()} ${dateDebut.hour.toString()}:${dateDebut.minute.toString()}',
                            style: TextStyle(color: Colors.blue),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
              child: TextFormField(
                controller: durationController,
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'durée',
                  labelStyle: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF95A1AC),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'durée du passage',
                  hintStyle: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF95A1AC),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                  prefixIcon: Icon(
                    Icons.timelapse,
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF090F13),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Stand Associer: "),
                    Query(
                        options: QueryOptions(
                            fetchPolicy: FetchPolicy.cacheAndNetwork,
                            document: gql(
                                GraphqlRequest().getStandForPassage)),
                        builder: (QueryResult result,
                            {VoidCallback? refetch,
                              FetchMore? fetchMore}) {
                          if (result.hasException) {
                            return Text(result.exception.toString());
                          }

                          if (result.isLoading) {
                            return const Text('Loading');
                          }

                          log(result.data.toString());

                          if (result.data?["stands"]?["data"] != null) {
                            var standsList =
                            result.data?["stands"]?["data"];

                            List<DropdownMenuItem<int>> standsDropItem =
                            standsList
                                .map<DropdownMenuItem<int>>(
                                    (i) => DropdownMenuItem<int>(
                                  value: int.parse(
                                      i["id"].toString()),
                                  child: Text(
                                      i["attributes"]
                                      ["name"]
                                          .toString()),
                                ))
                                .toList();

                            return DropdownButton<int>(
                              value: standValue,
                              items: standsDropItem,
                              onChanged: (newValue) {
                                setState(() {
                                  standValue = newValue ?? 1;
                                });
                              },
                            );
                          }

                          return CircularProgressIndicator();
                        }),
                  ],
                )),
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Artiste Associer: "),
                    Query(
                        options: QueryOptions(
                            fetchPolicy: FetchPolicy.cacheAndNetwork,
                            document: gql(
                                GraphqlRequest().getArtistForPassage)),
                        builder: (QueryResult result,
                            {VoidCallback? refetch,
                              FetchMore? fetchMore}) {
                          if (result.hasException) {
                            return Text(result.exception.toString());
                          }

                          if (result.isLoading) {
                            return const Text('Loading');
                          }

                          log(result.data.toString());

                          if (result.data?["artists"]?["data"] !=
                              null) {
                            var festivalList =
                            result.data?["artists"]?["data"];

                            List<DropdownMenuItem<int>>
                            festivalDropItem = festivalList
                                .map<DropdownMenuItem<int>>(
                                    (i) => DropdownMenuItem<int>(
                                  value: int.parse(
                                      i["id"].toString()),
                                  child: Text(
                                      i["attributes"]
                                      ["name"]
                                          .toString()),
                                ))
                                .toList();

                            return DropdownButton<int>(
                              value: artistValue,
                              items: festivalDropItem,
                              onChanged: (newValue) {
                                setState(() {
                                  artistValue = newValue ?? 1;
                                });
                              },
                            );
                          }

                          return CircularProgressIndicator();
                        }),
                  ],
                )),
            Align(
              alignment: AlignmentDirectional(0, 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Mutation(
                      options: MutationOptions(
                          document: gql(GraphqlRequest().deletePassage)
                          // this is the mutation string you just created

                          ),
                      builder: (
                        RunMutation runMutation,
                        QueryResult? result,
                      ) {
                        if (result?.exception != null) {
                          return Text(
                              result?.exception.toString() ?? "exception");
                        }

                        if (result?.data == null) {
                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () {
                                print('Button pressed ...');

                                runMutation({
                                  'id': widget.id,
                                });
                              },
                              child: Text(
                                'Supprimer le festival',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        } else {
                          log(result?.data.toString() ?? "test");

                          WidgetsBinding.instance?.addPostFrameCallback((_) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => PassageListePage()));
                          });

                          return const CircularProgressIndicator();
                        }
                      }),
                  Mutation(
                      options: MutationOptions(
                          document: gql(GraphqlRequest().editPassage)
                          // this is the mutation string you just created

                          ),
                      builder: (
                        RunMutation runMutation,
                        QueryResult? result,
                      ) {
                        if (result?.exception != null) {
                          return Text(
                              result?.exception.toString() ?? "exception");
                        }

                        if (result?.data == null) {
                          return Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                            child: ElevatedButton(
                              style: ButtonStyle(),
                              onPressed: () {
                                print('Button pressed ...');

                                runMutation({
                                  'id': widget.id,
                                  'dateStart': '${ DateFormat('yyyy-MM-dd').format(dateDebut)}T${ DateFormat('kk:mm:ss').format(dateDebut)}Z'
                                  ,
                                  'duration':
                                  int.parse(durationController.text) ?? 0,
                                  'stand': standValue,
                                  'artist': artistValue
                                });
                              },
                              child: Text(
                                'Modifier le festival',
                                style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        } else {
                          log(result?.data.toString() ?? "test");

                          WidgetsBinding.instance?.addPostFrameCallback((_) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => PassageListePage()));
                          });

                          return const CircularProgressIndicator();
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
