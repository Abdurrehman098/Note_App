import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_app/Core/models/note_model.dart';
import 'package:note_app/UI/Utils/show_messages.dart';
import 'package:note_app/main.dart';

class NoteProvider extends ChangeNotifier{

  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  List<NoteModel> notes =[];


  String? titleValidator(String? value){
    if(value==null || value.isEmpty){
      return "enter the title";

    }
    else {
      return null;
    }
  }
  String? descValidator(String? value){
    if(value==null || value.isEmpty){
      return "enter the title";

    }
    else {
      return null;
    }
  }

void addNote(String title , String desc)async{
    try{

      isLoading = true;
      notifyListeners();
      String id   = DateTime.now().millisecondsSinceEpoch.toString();
      NoteModel note = NoteModel(id, auth.currentUser!.uid, title, desc, DateTime.now());
      await db.collection("notes").doc(id).set(note.toMap());
      getNotes();
      Navigator.pop(navigatorKey.currentContext!);


    }
    on FirebaseException catch(e){
      showMsg(e.message);
    }
    catch(e){
      showMsg(e.toString());

    }
    finally{
      isLoading = false ;
      notifyListeners();

    }

}
  void getNotes ()async{
    notes.clear();
    try{
      isLoading =true;
      notifyListeners();
      final result = await db.collection("notes").get();
      for (var doc in result.docs){
     NoteModel note = NoteModel.fromMap(doc.data());
     notes.add(note);
      }

    }
    on FirebaseException catch(e){
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

  void deleteNote (NoteModel note)async{

    try{
      isLoading =true;
      notifyListeners();
      await db.collection('notes').doc(note.id).delete();
      getNotes();

    }

    on FirebaseException catch(e){
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



  void update(String title , String desc , String noteId) async{
    try {
      isLoading = true;
      notifyListeners();
      await db.collection('notes').doc(noteId).update({
        "title" : title,
        "desc"  : desc,
      });
      getNotes();
      Navigator.pop(navigatorKey.currentContext!);

    }
    on FirebaseException catch(e){
      showMsg(e.message);
    }

    catch (e) {
      showMsg(e.toString());

    }
    finally{
      isLoading = false;
      notifyListeners();
    }
  }


}
