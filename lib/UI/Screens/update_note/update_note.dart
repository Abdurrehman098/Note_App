import 'package:flutter/material.dart';
import 'package:note_app/Core/constant/auth_decoration.dart';
import 'package:note_app/Core/constant/colors.dart';
import 'package:note_app/Core/models/note_model.dart';
import 'package:note_app/Core/provider/note_provider.dart';
import 'package:provider/provider.dart';

class UpdateNote extends StatefulWidget {
  final NoteModel note;
  const UpdateNote({super.key , required this.note });

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  @override
  void initState() {
    super.initState();
   final provider =  Provider.of<NoteProvider>(context , listen: false);
    provider.title.text = widget.note.title;
    provider.desc.text = widget.note.desc;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(builder:(context, provider, child) {


      return Scaffold(
        appBar: AppBar(
          title: Text("update Note"),
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
                        provider.update(provider.title.text , provider.desc.text , widget.note.id);
                      }
                    }, child: provider.isLoading ? CircularProgressIndicator( color: Colors.white,): Text("Update",style: TextStyle(color: white),)),

              ],
            ),
          ),
        ),
      );
    },);


  }
}
