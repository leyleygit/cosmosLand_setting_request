import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_connect_mongdb/provider/app_state.dart';
import 'package:flutter_connect_mongdb/screens/home/home_screen.dart';
import 'package:flutter_connect_mongdb/screens/login/login_screen.dart';
import 'package:flutter_connect_mongdb/screens/request_verify_user.dart';
import 'package:provider/provider.dart';

class LoadingResource extends StatefulWidget {
  const LoadingResource({Key? key}) : super(key: key);

  @override
  State<LoadingResource> createState() => _LoadingResourceState();
}

class _LoadingResourceState extends State<LoadingResource> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<AppState>().userAppState;
    return user == null
        ? const RequestForVerifyUserScreen()
        : const RequestForVerifyUserScreen();
  }
}
