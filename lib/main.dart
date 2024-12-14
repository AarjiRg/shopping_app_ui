import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_ui/controller/cartscreencontroller.dart';
import 'package:shopping_app_ui/controller/detailscreencontroller.dart';
import 'package:shopping_app_ui/controller/homepagecontroller.dart';
import 'package:shopping_app_ui/model/cartmodel.dart';
import 'package:shopping_app_ui/view/screen_one/screenone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //step 1
  Hive.registerAdapter(CartmodelAdapter());

  var box = await Hive.openBox<Cartmodel>("cartbox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Homescreencontroller()),
        ChangeNotifierProvider(create: (context) => Detailcreencontroller()),
        ChangeNotifierProvider(create: (context) => Cartscreencontroller())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenOne(),
      ),
    );
  }
}
