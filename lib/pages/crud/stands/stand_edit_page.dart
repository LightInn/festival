import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../../utils/graphql_request.dart';
import 'stand_liste_page.dart';

class StandEditPage extends StatefulWidget {
  final int id;
  final int festivalID;
  final String standName;
  final String localisation;

  const StandEditPage(
      {Key? key,
      required this.id,
      required this.festivalID,
      required this.standName,
      required this.localisation})
      : super(key: key);

  @override
  _StandEditPageState createState() => _StandEditPageState();
}

class _StandEditPageState extends State<StandEditPage> {
  late TextEditingController standNameController;
  late TextEditingController localisationController;
  late int festivalID;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    localisationController = TextEditingController(text: widget.localisation);
    standNameController = TextEditingController(text: widget.standName);
    festivalID = widget.festivalID;
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
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
              child: TextFormField(
                controller: standNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Nom du festival',
                  labelStyle: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF95A1AC),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'Nom du festival',
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
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                  prefixIcon: Icon(
                    Icons.text_fields,
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
              child: TextFormField(
                controller: localisationController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Localisation',
                  labelStyle: TextStyle(
                    fontFamily: 'Lexend Deca',
                    color: Color(0xFF95A1AC),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'localisation du festival',
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
                  contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                  prefixIcon: Icon(
                    Icons.location_pin,
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
                    Text("Festival Associer: "),
                    Query(
                        options: QueryOptions(
                            fetchPolicy: FetchPolicy.cacheAndNetwork,
                            document:
                                gql(GraphqlRequest().getFestivalForStand)),
                        builder: (QueryResult result,
                            {VoidCallback? refetch, FetchMore? fetchMore}) {
                          if (result.hasException) {
                            return Text(result.exception.toString());
                          }

                          if (result.isLoading) {
                            return const Text('Loading');
                          }



                          if (result.data?["festivals"]?["data"] != null) {
                            var festivalList =
                                result.data?["festivals"]?["data"];

                            List<DropdownMenuItem<int>> festivalDropItem =
                                festivalList
                                    .map<DropdownMenuItem<int>>((i) =>
                                        DropdownMenuItem<int>(
                                          value: int.parse(i["id"].toString()),
                                          child: Text(i["attributes"]["name"]
                                              .toString()),
                                        ))
                                    .toList();

                            return DropdownButton<int>(
                              value: festivalID,
                              items: festivalDropItem,
                              onChanged: (newValue) {
                                setState(() {
                                  festivalID = newValue ?? 1;
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
                          document: gql(GraphqlRequest().deleteStands)
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


                          WidgetsBinding.instance?.addPostFrameCallback((_) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => StandListePage()));
                          });

                          return const CircularProgressIndicator();
                        }
                      }),
                  Mutation(
                      options: MutationOptions(
                          document: gql(GraphqlRequest().editStands)
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
                                  'name': standNameController.text,
                                  'position': localisationController.text,
                                  'festival': festivalID.toString()
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


                          WidgetsBinding.instance?.addPostFrameCallback((_) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => StandListePage()));
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
