import 'package:flutter/material.dart';
import 'package:note_app/Core/constant/auth_decoration.dart';
import 'package:note_app/Core/constant/colors.dart';
import 'package:note_app/Core/constant/strings.dart';
import 'package:note_app/Core/provider/my_auth_provider.dart';
import 'package:note_app/UI/Utils/route_helper.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => MyAuthProvider(),
      child: Consumer<MyAuthProvider>(builder: (context, provider, child) {


        return Scaffold(
          backgroundColor:Colors.grey,

          appBar: AppBar(
            title: Text("SignUp Screen", style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),),
            centerTitle: true,
            backgroundColor: purple,
          ),
          body: Form(
            key: provider.globalKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  Image.asset("$staticAssets/loginImage.webp", height: 220, width: double.infinity,),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: provider.nameController,
                      validator: provider.userNameValidate,
                      keyboardType: TextInputType.emailAddress,
                      decoration: authDecoration.copyWith(hintText: "enter your username" , labelText: "username"),


                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: provider.emailController,
                      validator: provider.emailValidator,
                      keyboardType: TextInputType.emailAddress,
                      decoration: authDecoration.copyWith(labelText: "email"),


                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: provider.passwordController,
                      validator: provider.passwordValidator,
                      decoration: authDecoration.copyWith(hintText: "********" ,labelText: "password",suffixIcon:Icon(Icons.remove_red_eye)),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16,),

                            ),
                        ),
                        onPressed: provider.isLoading ? null :(){

                          if (provider.globalKey.currentState!.validate()){
                            provider.signUp(provider.nameController.text, provider.emailController.text.trim(), provider.passwordController.text.trim());

                          }
                        }, child: provider.isLoading ? CircularProgressIndicator( color: Colors.white,) :Text("SignUp",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account "),
                      TextButton(onPressed: (){
                        Navigator.pushReplacementNamed(context, RouteHelper.login);
                      }, child: Text("Login", style: TextStyle(color: purple , fontWeight: FontWeight.bold),) ,)
                    ],
                  ),



                ],
              ),
            ),
          ),


        );
      },),
    );

  }
}

