import 'package:flutter/material.dart';

const authDecoration = InputDecoration(

  hintText: "example@gmail.com",
  suffixIcon: Icon(Icons.email),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6)),
    borderSide: BorderSide(width: 2 ,color: Colors.cyanAccent),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(width: 2 , color: Colors.cyanAccent),

  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(width: 3, color: Colors.cyanAccent),

  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 3 ,color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(16)),
  ),
  
  
);