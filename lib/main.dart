import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_screen.dart';

void main() async {
  runApp(MyApp());
  // Recebendo notificação quando ocorrer alteração na coleção e retornando-a
  /*  Firestore.instance.collection('mensagens').snapshots().listen((d) {
    d.documents.forEach((element) {
      //print(element.documentID);// Exibe todos os IDs dos documentos
      print(element.data);
    });
  }); */
} //main

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      home: ChatScreen(),
    );
  }
}
