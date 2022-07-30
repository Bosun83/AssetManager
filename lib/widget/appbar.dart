import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../page/asset_input_main_page.dart';

AppBar appBarPage(context) {
  return AppBar(
      title: Text(
        '머니',
        style: TextStyle(
          fontFamily: 'Nanum',
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AssetInputPage()),
              );
            }),
        IconButton(
          icon: Icon(Icons.refresh_rounded),
          onPressed: updateAssetStatus,
        ),
      ]);
}

void updateAssetStatus() {
  DocumentReference doc =
      FirebaseFirestore.instance.collection('AssetList').doc('TotalAsset');

  // CollectionReference col = FirebaseFirestore.instance.collection('AssetList');

  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(doc);
    if (!snapshot.exists) {
      throw Exception('Does not exists');
    }
    int currentValue = snapshot.get('evaluatedValue');

    transaction.update(doc, {'evaluatedValue': currentValue + 999});
  });
}
