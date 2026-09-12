import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/Core/provider/my_auth_provider.dart';
import 'package:note_app/Core/provider/note_provider.dart';
import 'package:note_app/UI/Utils/route_helper.dart';
import 'package:note_app/main.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            centerTitle: true,
            backgroundColor: Colors.cyanAccent,

            actions: [
              Consumer<MyAuthProvider>(
                builder: (context , provider , child) {
                  return IconButton(onPressed: (){
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout "),
                      actions: [
                        ElevatedButton(onPressed: (){
                          Navigator.pop(navigatorKey.currentContext!);
                        }, child: Text("No")),
                        ElevatedButton(onPressed: (){
                          Navigator.pop(navigatorKey.currentContext!);
                          provider.logout();
                        }, child: Text("Yes")),
                      ],
                    ),);

                  }, icon: Icon(Icons.logout));
                }
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteHelper.addNote);
            },
            child: Icon(Icons.add),
          ),

          body: provider.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    for (var note in provider.notes)
                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              navigatorKey.currentContext!,
                              RouteHelper.updateNote,
                              arguments: note,
                            );
                          },
                          child: ListTile(
                            leading: Icon(CupertinoIcons.book),
                            title: Text(note.title),
                            subtitle: Text(
                              note.desc,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                provider.deleteNote(note);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }
}
