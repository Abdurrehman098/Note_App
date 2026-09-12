import 'package:flutter/material.dart';
import 'package:note_app/Core/constant/auth_decoration.dart';
import 'package:note_app/Core/constant/colors.dart';
import 'package:note_app/Core/constant/strings.dart';
import 'package:note_app/Core/provider/my_auth_provider.dart';
import 'package:note_app/UI/Utils/route_helper.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => MyAuthProvider(),
    child: Consumer<MyAuthProvider>(builder: (context, provider, child) {


    return Scaffold(
      backgroundColor:Colors.grey.shade300,

      appBar: AppBar(
        title: Text("Login Screen", style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: purple,
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: provider.globalKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                Image.asset("$staticAssets/loginImage.webp",  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,

                ),

             SizedBox(height: 10,),
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
                    obscureText: !provider.isPasswordVisibility,
                    controller: provider.passwordController,
                    validator: provider.passwordValidator,
                    decoration: authDecoration.copyWith(hintText: "********" ,labelText: "password",suffixIcon:IconButton(onPressed: (){
                   provider.togglePasswordVisibility();
                    }, icon: Icon (provider.isPasswordVisibility ? Icons.visibility : Icons.visibility_off))),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purple,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16,),

                        )
                      ),
                      onPressed: provider.isLoading ? null :(){
                        FocusScope.of(context).unfocus();

                        if (provider.globalKey.currentState!.validate()){
                          provider.login(provider.emailController.text.trim(), provider.passwordController.text.trim());

                        }
                      }, child: provider.isLoading? CircularProgressIndicator(color: Colors.white,): Text("Login",style: TextStyle(fontWeight: FontWeight.bold ,color: white),)),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account "),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, RouteHelper.signUp);
                    }, child: Text("SingUp", style: TextStyle(color: purple , fontWeight: FontWeight.bold),) ,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextButton(onPressed: (){
                        Navigator.pushNamed(context, RouteHelper.forgotPassword);
                      }, child: Text("Forgot Password" , style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),

                  ],
                ),

               ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: purple,
                   ),
                   onPressed: provider.googleSignInLoading ? null :(){
                     provider.continueWithGoogle();

                   }, child: provider.googleSignInLoading? CircularProgressIndicator(color: Colors.white,) : Text("google SignIn" ,style: TextStyle(color: white , fontWeight: FontWeight.bold),))




              ],
            ),
          ),
        ),
      ),


    );
    },),
    );

  }
}
