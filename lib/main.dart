import 'package:flutter_connect_mongdb/loading_resource.dart';
import 'package:flutter_connect_mongdb/screens/login/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_connect_mongdb/provider/app_state.dart';
import 'package:flutter_connect_mongdb/screens/home/home_screen.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('myBox');

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AppState())],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var uri = "mongodb+srv://kerker:kerker@kerker.wyfcw.mongodb.net/stock";
  Future<mongo.Db> initMongo() async {
    mongo.Db? db = await mongo.Db.create(uri);
    await db.open();
    return db;
  }

  @override
  void initState() {
    super.initState();
    context.read<AppState>().getIdFromBox();
    //
    initMongo().then((mongo.Db db) {
      if (db.isConnected) {
        context.read<AppState>().setDb(db);
      } else {
        showDialog(context: context, builder: (_) => const Dialog());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingResource(),
    );
  }
}
