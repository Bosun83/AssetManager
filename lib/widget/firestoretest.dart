import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void firebaseTest() async{
  var documentSnapshot = await FirebaseFirestore.instance.collection('AssetList').doc('TotalAsset').get();
     print(documentSnapshot.data());

  var collectionSnapshot = FirebaseFirestore.instance.collection('AssetList').snapshots();

  await for(var snapshot in collectionSnapshot) {
    for(var message in snapshot.docs) {
      print(message.data());
    }
  }
}

Widget streamTest(){
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('AssetList').snapshots(),
    builder: (context, snapshot){
      if(snapshot.hasData){
        var docLength = snapshot.data!.docs.length;
        DocumentSnapshot documentSnapshot = snapshot.data!.docs[docLength];
        print(documentSnapshot);

        return CircularProgressIndicator();
      }
      else
        return CircularProgressIndicator();
    },
  );
}