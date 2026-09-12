
import 'package:flutter/material.dart';
import 'package:note_app/Core/models/note_model.dart';
import 'package:note_app/UI/Screens/Add_Note_screen/add_note_screen.dart';
import 'package:note_app/UI/Screens/Auth/signup_screen.dart';
import 'package:note_app/UI/Screens/Auth/forget_password_screen.dart';
import 'package:note_app/UI/Screens/Auth/login_screen.dart';
import 'package:note_app/UI/Screens/home_screen/home_screen.dart';
import 'package:note_app/UI/Screens/splash_screen/splash_screen.dart';
import 'package:note_app/UI/Screens/update_note/update_note.dart';

class RouteHelper {

 static String initial = ('/');
 static String login = ('/login');
 static String signUp = ('/signup');
 static String forgotPassword = ('/forgotPassword');
 static String home = ('/home');
 static String addNote = ('/addNote');
 static const String updateNote = ('/updateNote');

 static Map<String , WidgetBuilder> routes() => {
   initial:(context)=>SplashScreen(),
   login : (context)=> LoginScreen(),
   signUp : (context)=> SignupScreen(),
   forgotPassword : (context)=> ForgetPasswordScreen(),
   home:(context)=>HomeScreen(),
   addNote : (context)=> AddNoteScreen(),

  };
 static Route<dynamic>? onGenerateRoutes(RouteSettings settings){

   switch(settings.name){
     case updateNote :{
       NoteModel note =settings.arguments as NoteModel;
       return MaterialPageRoute(builder: (context) => UpdateNote(note : note),);}
     default:
       return null;



   }
 }


}
