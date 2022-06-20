import 'dart:developer';

import 'package:festival2/pages/crud/stands/stand_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../../utils/graphql_request.dart';

class StandNewPage extends StatefulWidget {
  const StandNewPage({Key? key}) : super(key: key);

  @override
  _StandNewPageState createState() => _StandNewPageState();
}

class _StandNewPageState extends State<StandNewPage> {
  late TextEditingController festivalNameController;
  late TextEditingController localisationController;
  late int dropdownValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    localisationController = TextEditingController(text: 'Nantes');
    festivalNameController = TextEditingController(text: 'Festival');
    dropdownValue = 1;
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
                    'Créer un Stand',
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
        child: Mutation(
            options:
                MutationOptions(document: gql(GraphqlRequest().createStands)
                    // this is the mutation string you just created

                    ),
            builder: (
              RunMutation runMutation,
              QueryResult? result,
            ) {
              if (result?.exception != null) {
                return Text(result?.exception.toString() ?? "exception");
              }

              if (result?.data == null) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
                      child: TextFormField(
                        controller: festivalNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Nom du stand',
                          labelStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF95A1AC),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Nom du stand',
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
                          hintText: 'localisation du stand',
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

                                      log(result.data.toString());

                                      if (result.data?["festivals"]?["data"] != null) {
                                        var festivalList =
                                            result.data?["festivals"]?["data"];




                                        List<DropdownMenuItem<int>> festivalDropItem =
                                            festivalList.map<DropdownMenuItem<int>>(
                                                (i) => DropdownMenuItem<int>(
                                                      value:
                                                          int.parse(i["id"].toString()),
                                                      child: Text(i["attributes"]
                                                              ["name"]
                                                          .toString()),
                                                    )).toList();

                                        return DropdownButton<int>(
                                          value: dropdownValue,
                                          items: festivalDropItem,
                                          onChanged: (newValue) {
                                            setState(() {
                                              dropdownValue = newValue ?? 1;
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
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                        child: ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () {
                            print('Button pressed ...');

                            runMutation({
                              'name': festivalNameController.text,
                              'position': localisationController.text

                            });
                          },
                          child: Text(
                            'Créer le stand',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                log(result?.data.toString() ?? "test");

                Navigator.of(context).pop();

                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
