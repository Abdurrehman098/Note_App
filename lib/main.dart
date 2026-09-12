import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Core/provider/my_auth_provider.dart';
import 'package:note_app/Core/provider/note_provider.dart';
import 'package:note_app/UI/Utils/route_helper.dart';
import 'package:note_app/firebase_options.dart';
import 'package:provider/provider.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final navigatorKey = GlobalKey<NavigatorState>();
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );

  runApp(NoteApp());
}
class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => MyAuthProvider(),),
        ChangeNotifierProvider(create: (context) => NoteProvider(),)
      ],
      child:MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: RouteHelper.routes(),
      onGenerateRoute: (settings) => RouteHelper.onGenerateRoutes(settings),
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,

      )
    );
  }
}
