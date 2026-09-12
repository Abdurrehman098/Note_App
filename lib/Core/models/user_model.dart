class UserModel {
  String id , name ,  email;
  DateTime createdAt;

UserModel(this.id , this.name ,this.email , this.createdAt);

Map<String , dynamic>toMap(){
  return{
    "id " : id,
    "name" : name,
    "email" : email,
    "createdAt" : createdAt.toString(),

  };
}

}



