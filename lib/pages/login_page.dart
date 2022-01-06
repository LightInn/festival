import 'dart:developer';
import 'package:festival/services/AuthentificationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // ! 0x00FFFFFF
              Container(
                color: const Color(0xffdbc5ff),
                // color: const Color(0xFFC73800),
                width: wid,
                height: 350,
                child: SvgPicture.asset(
                  "images/wave8.svg",
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
          // ! Here input

          Expanded(
            child: Container(
              color: const Color(0xffdbc5ff),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        height: 240,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 2),
                        decoration: const BoxDecoration(
                            // border: Border.all(
                            //     color: const Color(0xff4f1ed2), width: 1),
                            // boxShadow: const [
                            //   BoxShadow(
                            //       color: Color(0xff4f1ed2),
                            //       blurRadius: 10,
                            //       offset: Offset(1, 1)),
                            // ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.email_outlined),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      controller: _emailController,
                                      maxLines: 1,
                                      decoration: const InputDecoration(
                                        label: Text(" Email ..."),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 5,
                              thickness: 3,
                              indent: 50,
                              endIndent: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.password_outlined),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      maxLines: 1,
                                      decoration: const InputDecoration(
                                        label: Text(" Password ..."),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 22, right: 22),
                      child: ElevatedButton(
                        onPressed: () {
                          login(_emailController.text, _passwordController.text)
                              .then((value) => {
                                    log("jwt recu = " + (value.jwt ?? "null")),
                                    storage.write(key: 'jwt', value: value.jwt)
                                  })
                              .then((value) =>
                                  Navigator.of(context).pushNamed("/home"));
                        },
                        style: ElevatedButton.styleFrom(
                            onPrimary: const Color(0xff4f1ed2),
                            shadowColor: const Color(0xff4f1ed2),
                            elevation: 18,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xff4f1ed2), Color(0xff4f1ed2)]),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            width: wid - 20,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: TextButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed("/register")},
                        child: Text("SingUp if don't have account ",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
