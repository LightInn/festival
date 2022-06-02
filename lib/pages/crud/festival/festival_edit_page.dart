import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../../utils/graphql_request.dart';
import 'festival_liste_page.dart';

class FestivalEditPage extends StatefulWidget {
  final int id;
  final String dateDebut;
  final String dateFin;
  final String festivalName;
  final String localisation;

  const FestivalEditPage(
      {Key? key,
      required this.id,
      required this.dateDebut,
      required this.dateFin,
      required this.festivalName,
      required this.localisation})
      : super(key: key);

  @override
  _FestivalEditPageState createState() => _FestivalEditPageState();
}

class _FestivalEditPageState extends State<FestivalEditPage> {
  late DateTime dateDebut;

  late DateTime dateFin;

  late TextEditingController festivalNameController;
  late TextEditingController localisationController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    dateDebut = DateTime.parse(widget.dateDebut);
    dateFin = DateTime.parse(widget.dateFin);
    localisationController = TextEditingController(text: widget.localisation);
    festivalNameController = TextEditingController(text: widget.festivalName);
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
                controller: festivalNameController,
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
              padding: EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      'Date de debut du festival : ',
                    ),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
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
                            }, currentTime: dateDebut, locale: LocaleType.fr);
                          },
                          child: Text(
                            '${dateDebut.day.toString()}/${dateDebut.month.toString()}/${dateDebut.year.toString()} ',
                            style: TextStyle(color: Colors.blue),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      'Date de fin du festival : ',
                    ),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      child: OutlinedButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(1900, 3, 5),
                                maxTime: DateTime(2100, 6, 7),
                                onChanged: (date) {
                              dateFin = date;
                              print('change $date');
                            }, onConfirm: (date) {
                              setState(() {
                                dateFin = date;
                                print('confirm $date');
                              });
                            }, currentTime: dateFin, locale: LocaleType.fr);
                          },
                          child: Text(
                            '${dateFin.day.toString()}/${dateFin.month.toString()}/${dateFin.year.toString()} ',
                            style: TextStyle(color: Colors.blue),
                          ))),
                ],
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
            Align(
              alignment: AlignmentDirectional(0, 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Mutation(
                      options: MutationOptions(
                          document: gql(GraphqlRequest().deleteFestival)
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
                                    builder: (context) => FestivalListePage()));
                          });





                          return const CircularProgressIndicator();
                        }
                      }),
                  Mutation(
                      options: MutationOptions(
                          document: gql(GraphqlRequest().editFestival)
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
                                  'name': festivalNameController.text,
                                  'date_start': DateFormat('yyyy-MM-dd')
                                      .format(dateDebut),
                                  'date_end':
                                      DateFormat('yyyy-MM-dd').format(dateFin),
                                  'localisation': localisationController.text
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
                                    builder: (context) => FestivalListePage()));
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
