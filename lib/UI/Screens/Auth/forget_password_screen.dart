import 'package:flutter/material.dart';
import 'package:note_app/Core/constant/auth_decoration.dart';
import 'package:note_app/Core/constant/colors.dart';
import 'package:note_app/Core/constant/strings.dart';
import 'package:note_app/Core/provider/my_auth_provider.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(create: (context) => MyAuthProvider(),
      child: Consumer<MyAuthProvider>(builder: (context, provider, child) {


        return Scaffold(
          backgroundColor:Colors.grey.shade300,

          appBar: AppBar(
            title: Text("Forgot Password", style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),),
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
                      controller: provider.emailController,
                      validator: provider.emailValidator,
                      keyboardType: TextInputType.emailAddress,
                      decoration: authDecoration,


                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16,),

                            )
                        ),
                        onPressed: provider.isLoading ? null :  (){

                          if (provider.globalKey.currentState!.validate()){
                            provider.forgetPassword(provider.emailController.text.trim());

                          }
                        }, child: provider.isLoading ? CircularProgressIndicator( color: Colors.white,) :Text("Reset Password",style: TextStyle(fontWeight: FontWeight.bold),)),
                  )



                ],
              ),
            ),
          ),


        );
      },),
    );

  }
}

