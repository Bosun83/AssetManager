import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String numberWithComma(int param) {
  return new NumberFormat('###,###,###,###').format(param).replaceAll(' ', '');
}

int remainingDays(String date) {
  var _today = DateTime.now();
  int difference =
      int.parse(_today.difference(DateTime.parse(date)).inDays.toString());
  return difference;
}

Widget mainListView() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('AssetList').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot documentSnapshot =
                snapshot.data!.docs[index];
            if (documentSnapshot['assetType'] == '부동산')
              return Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.all(3),
                child: ListTile(
                  leading: Container(
                      width: 40,
                      height: 40,
                      child: Text(
                        '부동산',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                  title: Text(
                    documentSnapshot['assetName'],
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 16,
                      // fontStyle: FontStyle.normal,
                      // fontWeight: FontWeight.bold,
                      // color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    '구입일 : ' +
                        DateFormat.yMMMd()
                            .format(documentSnapshot['boughtDate'].toDate())
                            .toString(),
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  trailing: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          numberWithComma(documentSnapshot['actualPrice']) +
                              '원',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          numberWithComma(documentSnapshot['actualPrice'] -
                                  documentSnapshot['boughtPrice']) +
                              '원' +
                              '(' +
                              (documentSnapshot['boughtPrice'] /
                                      documentSnapshot['actualPrice'] *
                                      100)
                                  .toStringAsFixed(2) +
                              '%)',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            else if (documentSnapshot['assetType'] == '주식')
              return Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.all(3),
                child: ListTile(
                  leading: Container(
                      width: 40,
                      height: 40,
                      child: Text(
                        '주식',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                  title: Text(
                    documentSnapshot['assetName'],
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    '주식수 : ' +
                        documentSnapshot['amount'].toString() +
                        '주' ', 보유일 : ' +
                        remainingDays(documentSnapshot['boughtDate']
                                .toDate()
                                .toString())
                            .toString() +
                        '일',
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  trailing: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          numberWithComma(documentSnapshot['currentPrice'] *
                                  documentSnapshot['amount']) +
                              '원',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          numberWithComma(documentSnapshot['currentPrice'] *
                                      documentSnapshot['amount'] -
                                  documentSnapshot['averagePrice'] *
                                      documentSnapshot['amount']) +
                              '원' +
                              '(' +
                              (documentSnapshot['averagePrice'] /
                                      documentSnapshot['currentPrice'] *
                                      100)
                                  .toStringAsFixed(2) +
                              '%)',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            else if (documentSnapshot['assetType'] == '펀드')
              return Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.all(3),
                child: ListTile(
                  leading: Container(
                      width: 40,
                      height: 40,
                      child: Text(
                        '펀드',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                  title: Text(
                    documentSnapshot['assetName'],
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    '가입일 : '+ documentSnapshot['boughtDate'],
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  trailing: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          numberWithComma(documentSnapshot['currentPrice'] *
                              documentSnapshot['amount']) +
                              '원',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          numberWithComma(documentSnapshot['currentPrice'] *
                              documentSnapshot['amount'] -
                              documentSnapshot['averagePrice'] *
                                  documentSnapshot['amount']) +
                              '원' +
                              '(' +
                              (documentSnapshot['averagePrice'] /
                                  documentSnapshot['currentPrice'] *
                                  100)
                                  .toStringAsFixed(2) +
                              '%)',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            else
              return CircularProgressIndicator();
          },
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
