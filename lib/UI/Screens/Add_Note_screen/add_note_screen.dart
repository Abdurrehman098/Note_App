import 'package:flutter/material.dart';
import 'package:note_app/Core/constant/auth_decoration.dart';
import 'package:note_app/Core/constant/colors.dart';
import 'package:note_app/Core/provider/note_provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  void initState() {
    super.initState();

    final provider = Provider.of<NoteProvider>(
      context,
      listen: false,
    );

    // Clear previous data
    provider.title.clear();
    provider.desc.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(builder:(context, provider, child) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
        centerTitle: true,
        backgroundColor: purple,

      ),

      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: provider.globalKey,
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              SizedBox(height: 20,),
              TextFormField(
                controller: provider.title,
                validator: provider.titleValidator,
                decoration: authDecoration.copyWith(hintText: "Title" , suffixIcon: SizedBox.shrink(),

                ),
              ),
              SizedBox(height: 15,),

              TextFormField(
                controller: provider.desc,
                validator: provider.descValidator,

                maxLines: 6,
                decoration: authDecoration.copyWith(hintText: "Description",suffixIcon: SizedBox.shrink()),

              ),
              SizedBox(height: 15,),


              ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      backgroundColor: purple,
                      minimumSize: Size(double.infinity, 50)
                    ),
                    onPressed: provider.isLoading ? null : (){
                      FocusScope.of(context).unfocus();
                      if (provider.globalKey.currentState!.validate()){
                       provider.addNote(provider.title.text, provider.desc.text);
                      }
                    }, child: provider.isLoading ? CircularProgressIndicator( color: Colors.white,): Text("Saved",style: TextStyle(color: white),)),

            ],
          ),
        ),
      ),
    );
  },);

  }
}
