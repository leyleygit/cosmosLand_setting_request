import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_connect_mongdb/provider/app_state.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

class LoginScreen extends StatefulWidget {
  BehaviorSubject<bool> subjectValueCheckBox = BehaviorSubject<bool>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isShowPassword = true;
  BehaviorSubject<bool> subjectShowPassword = BehaviorSubject<bool>();
  final myBox = Hive.box('myBox');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(slivers: [
          const SliverToBoxAdapter(
            child: Center(
                child: Text(
              'Login',
              style: TextStyle(fontSize: 50),
            )),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20),
            //Form Loign here
            sliver: Form(
              key: formKey,
              child: SliverList(
                  delegate: SliverChildListDelegate([
                //username textField
                TextFormField(
                  onChanged: (value) => setState(() {}),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please insert username';
                    }
                    return null;
                  },
                  controller: usernameController,
                  decoration: const InputDecoration(hintText: 'Username'),
                ),
                //password textField
                StreamBuilder<bool>(
                    initialData: true,
                    stream: subjectShowPassword,
                    builder: (context, AsyncSnapshot snapshot) {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: snapshot.data,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please insert password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            hintText: 'password',
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    isShowPassword = !isShowPassword;
                                    subjectShowPassword.add(isShowPassword);
                                  },
                                  child: snapshot.data == true
                                      ? const Icon(
                                          CarbonIcons.view_off_filled,
                                          color: Colors.grey,
                                        )
                                      : const Icon(
                                          CarbonIcons.view_filled,
                                          color: Colors.grey,
                                        )),
                            )),
                      );
                    }),
                StreamBuilder<bool>(
                    initialData: false,
                    stream: widget.subjectValueCheckBox,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.platform,
                        title: const Text('Save password'),
                        value: snapshot.data,
                        onChanged: (value) {
                          widget.subjectValueCheckBox.add(value!);
                        },
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                      );
                    }),
                ElevatedButton(
                    onPressed: formKey.currentState != null &&
                            formKey.currentState!.validate()
                        ? () async {
                            var db = context.read<AppState>().db;
                            await db!.collection('users').findOne({
                              "userName": usernameController.text
                            }).then((value) async {
                              if (value!["password"] ==
                                  passwordController.text) {
                                // if (snapshot.data == false &&
                                //     snapshot.data == null) {
                                //   return null;
                                // }else{
                                //   return myBox.put('save', context.read<AppState>().setUser(value));
                                // }

                                context.read<AppState>().setUser(value);

                                await myBox.put('id', value['_id'].toString());
                              } else {
                                return "no user or wrong username password";
                              }
                            });
                          }
                        : null,
                    child: const Text('Login now'))
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
