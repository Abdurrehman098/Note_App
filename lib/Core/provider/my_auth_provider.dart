import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/Core/models/user_model.dart';
import 'package:note_app/UI/Utils/route_helper.dart';
import 'package:note_app/UI/Utils/show_messages.dart';
import 'package:note_app/main.dart';

class MyAuthProvider extends ChangeNotifier{

  FirebaseAuth auth =FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool googleSignInLoading = false;
  bool isPasswordVisibility = false;

  final globalKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;


  void togglePasswordVisibility (){
    isPasswordVisibility = !isPasswordVisibility;
    notifyListeners();
  }




  String? emailValidator(String? value){
    if(value==null || value.isEmpty){
      return "enter the email";
    }
    else {
      return null ;
    }
  }
  String? passwordValidator(String? value){
    if (value==null || value.isEmpty){
      return "enter your password";

    }
    else if(value.length < 8){
      return 'your password must be at least 8 character';

    }
    else{
      return null ;
    }

  }
  String? userNameValidate(String? value){
    if(value==null || value.isEmpty){
      return " enter your user name";

    }
    else if( value.length <3 ){
      return "your name must be at least 3 character";

    }
    else{
      return null;
    }
  }




void continueWithGoogle()async{
    googleSignInLoading= true;
    notifyListeners();

    String webClientId = "188401743505-ob1tmudqfpl99ecus5gtflniamq8md5c.apps.googleusercontent.com";
    try{
      GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(serverClientId: webClientId);
       GoogleSignInAccount account =  await signIn.authenticate();
       GoogleSignInAuthentication googleAuth = account.authentication;
       final credential = GoogleAuthProvider.credential(
         idToken: googleAuth.idToken
       );
       await auth.signInWithCredential(credential);
       Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, RouteHelper.home, (value)=>false);



    }
    on FirebaseException catch(e){
      showMsg(e.message);
    }
    catch(e){
      showMsg(e.toString());

    }
    finally{
      googleSignInLoading=false;
      notifyListeners();
    }

}





  void login(String email , String password)async{

    try{
      isLoading = true;
      notifyListeners();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, RouteHelper.home ,(value)=>false);

    }
    on FirebaseAuthException catch(e){
      showMsg(e.message);
    }
    catch(e){
      showMsg(e.toString());


    }
    finally{
      isLoading =false;
      notifyListeners();


    }
  }

  void signUp(String name  , String email , String password)async{
    try{
      isLoading = true;
      notifyListeners();
     final result=  await auth.createUserWithEmailAndPassword(email: email, password: password);
      UserModel user = UserModel(
          result.user!.uid,
          name,
          email,
          DateTime.now());
      await db.collection("users").doc(result.user!.uid).set(user.toMap());
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, RouteHelper.home , (value)=>false);

    }
    on FirebaseAuthException catch(e){
      showMsg(e.message);
    }
    catch(e){
      showMsg(e.toString());

    }
    finally{
      isLoading =false;
      notifyListeners();

    }

  }

  Future<void> forgetPassword(String email)async{
    try{
      isLoading =true;
      notifyListeners();
      await auth.sendPasswordResetEmail(email: email.trim());

      showMsg("Password reset email sent. Please check your inbox.");
    }


    on FirebaseAuthException catch(e){
      showMsg(e.message);

    }
    catch(e){
      showMsg(e.toString());


    }
    finally{
      isLoading =false;
      notifyListeners();

    }
  }


  void logout ()async{

    try{

      await auth.signOut();
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, RouteHelper.login , (value)=> false);
    }
    on FirebaseAuthException catch(e){
      showMsg(e.message);
    }
    catch (e){
      showMsg(e.toString());

    }

  }


}