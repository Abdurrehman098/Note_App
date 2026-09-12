class NoteModel {
  String id , userId , title , desc ;
  DateTime createdAt;

  NoteModel(this.id , this.userId , this.title , this.desc , this.createdAt);

  factory NoteModel.fromMap(Map<String , dynamic>map){
    
    return NoteModel(map['id'], map["userId"], map["title"], map['desc'],
    DateTime.parse(map['createdAt'])
    );

    }



  Map<String , dynamic> toMap(){
    return{
      "id" : id,
      "userId" : userId,
      "title" :title,
      "desc" : desc,
      "createdAt" : createdAt.toString()
    };
  }



}