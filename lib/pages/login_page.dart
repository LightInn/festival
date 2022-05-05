import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/jwt_token.dart';
import 'register_page.dart';
// import 'package:login_ui/register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;

  @override
  Widget build(BuildContext context) {
    String? identifier;
    String? password;

    String loginMutation =
        """mutation(\$identifier:String!,\$password:String!){login(input:{identifier:\$identifier,password:\$password }){jwt,user{email}}}""";

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (String? value) {
                      identifier = value;
                    },
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : "Please enter a valid email",
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (String? value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text("Remember me"),
                    contentPadding: EdgeInsets.zero,
                    value: rememberValue,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (newValue) {
                      setState(() {
                        rememberValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Mutation(
                      options: MutationOptions(document: gql(loginMutation)
                          // this is the mutation string you just created

                          ),
                      builder: (
                        RunMutation runMutation,
                        QueryResult? result,
                      ) {

                        if(result?.exception != null){
                          log(result?.exception.toString() ?? "error error");
                        }


                        if (result?.data == null) {
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();

                                runMutation({
                                  'identifier': identifier,
                                  'password': password,
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                            ),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          String? jwt = result?.data?['login']?['jwt'];

                          if (jwt != null) {
                            JwtToken().setToken("Bearer " + jwt);
                          }
                          Navigator.of(context).pushNamed("/home");

                          return CircularProgressIndicator();
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not registered yet?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPage(title: 'Register UI'),
                            ),
                          );
                        },
                        child: const Text('Create an account'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
