import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

const imageOfApt = 'https://cdn-icons-png.flaticon.com/512/1838/1838402.png';
const imageOfStock =
    'https://cdn.icon-icons.com/icons2/908/PNG/512/stocks-ascendant-graphic_icon-icons.com_70604.png';
const imageOfDebt = 'https://cdn-icons-png.flaticon.com/512/1086/1086830.png';
const imageOfNetvalue =
    'https://cdn0.iconfinder.com/data/icons/finance-dualine-flat-vol-2/64/Net_Worth-512.png';
const imageOfAsset = 'https://cdn-icons-png.flaticon.com/512/1907/1907675.png';
const imageOfDeposit = 'https://cdn-icons-png.flaticon.com/512/2746/2746077.png';

String numberWithComma(int param) {
  return NumberFormat('###,###,###,###').format(param).replaceAll(' ', '');
}

int remainingDays(String date) {
  var _today = DateTime.now();
  int difference =
      int.parse(_today.difference(DateTime.parse(date)).inDays.toString());
  return difference;
}

Widget bodyGroupedListView() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('AssetList').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasData) {
        return GroupedListView<dynamic, String>(
            physics: BouncingScrollPhysics(),
            elements: snapshot.data!.docs,
            groupBy: (element) => element['assetType'],
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item1['evaluatedValue'].compareTo(item2['evaluatedValue']),
            order: GroupedListOrder.DESC,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (String value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        value,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.pacifico(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 100, height: 50),
                      if (value == 'Reserved')
                        Expanded(
                          child: Text(
                            '10000000000원',
                            textAlign: TextAlign.end,
                            style: GoogleFonts.pacifico(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
            itemBuilder: (c, element) {
              if (element['assetType'] == '주식') {
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
                        child: Image.network(imageOfStock)),
                    title: Text(
                      element['assetName'],
                      style: TextStyle(
                        fontFamily: 'Nanum',
                        fontSize: 16,
                        // fontStyle: FontStyle.normal,
                        // fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      '주식수 : ' +
                          element['amount'].toString() +
                          '주\n' '평균구입가 : ' +
                          element['averagePrice'].toString() +
                          '원',
                      style: TextStyle(
                        fontFamily: 'Nanum',
                        fontSize: 12,
                        // fontStyle: FontStyle.normal,
                        // fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    trailing: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            numberWithComma(element['currentPrice'] *
                                    element['amount']) +
                                '원',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            numberWithComma(element['currentPrice'] *
                                        element['amount'] -
                                    element['averagePrice'] *
                                        element['amount']) +
                                '원' +
                                '(' +
                                ((element['currentPrice'] -
                                            element['averagePrice']) *
                                        element['amount'] /
                                        (element['averagePrice'] *
                                            element['amount']) *
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
              } else if (element['assetType'] == '부동산')
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
                        child: Image.network(imageOfApt)),
                    title: Text(
                      element['assetName'],
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
                              .format(element['boughtDate'].toDate())
                              .toString(),
                      style: TextStyle(
                        fontFamily: 'Nanum',
                        fontSize: 12,
                        // fontStyle: FontStyle.normal,
                        // fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    trailing: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            numberWithComma(element['actualPrice']) + '원',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            numberWithComma(element['actualPrice'] -
                                    element['boughtPrice']) +
                                '원' +
                                '(' +
                                ((element['actualPrice'] -
                                            element['boughtPrice']) /
                                        element['boughtPrice'] *
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
              else if (element['assetType'] == '예금')
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
                        child: Image.network(imageOfDeposit)),
                    title: Text(
                      element['assetName'],
                      style: TextStyle(
                        fontFamily: 'Nanum',
                        fontSize: 16,
                        // fontStyle: FontStyle.normal,
                        // fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      '만기일 : ' +
                          DateFormat.yMMMd()
                              .format(element['endDate'].toDate())
                              .toString() +
                          '\n이자율 : ' +
                          element['interestRate'].toString() +
                          '%',
                      style: TextStyle(
                        fontFamily: 'Nanum',
                        fontSize: 12,
                        // fontStyle: FontStyle.normal,
                        // fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    trailing: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            numberWithComma(element['principal']) + '원',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              else if (element['assetName'] == '자산') {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.yellow,
                    child: Row(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            child: Image.network(imageOfAsset)),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(element['assetName'],
                              style: TextStyle(
                                fontFamily: 'Maru',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // fontStyle: FontStyle.normal,
                                color: Colors.white,
                              )),
                        ),
                        Text(numberWithComma(element['evaluatedValue']) + '원',
                            style: GoogleFonts.pacifico(
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                );
              } else if (element['assetName'] == '부채')
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.redAccent,
                    child: Row(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            child: Image.network(imageOfDebt)),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(element['assetName'],
                              style: TextStyle(
                                fontFamily: 'Maru',
                                fontSize: 20,
                                // fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ),
                        Text(numberWithComma(element['evaluatedValue']) + '원',
                            style: GoogleFonts.pacifico(
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                );
              else if (element['assetName'] == '자본')
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.green,
                    child: Row(
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            child: Image.network(imageOfNetvalue)),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(element['assetName'] + '(자산-부채)',
                              style: GoogleFonts.lato(
                                // textStyle: Theme.of(context).textTheme.headline1,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                              )),
                        ),
                        Text(numberWithComma(element['evaluatedValue']) + '원',
                            style: GoogleFonts.pacifico(
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                );
              else
                return CircularProgressIndicator();
            });
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
