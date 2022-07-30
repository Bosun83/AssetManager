import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../page/debtInputPage.dart';
import '../page/stockInputPage.dart';
import '../page/realStateInput.dart';
import '../page/depositInputPage.dart';

class AssetInputPage extends StatefulWidget {
  @override
  _AssetInputPageState createState() => _AssetInputPageState();
}

class _AssetInputPageState extends State<AssetInputPage> {
  final _formStateKey1 = GlobalKey<FormFieldState>();
  final _formStateKey2 = GlobalKey<FormFieldState>();

  dynamic defaultAssetOrDebt = '자산';
  dynamic defaultAsset = '주식';
  dynamic defaultDebt = '주택담보대출';
  dynamic tollogDebtToAsset = '주식';

  final assetOrDebt = [
    '자산',
    '부채',
  ];

  var toggleBetweenAssetAndDebt = [
    '부동산',
    '분양권',
    '주식',
    '펀드',
    '채권',
    '연금저축',
    '예금',
    '청약저축',
    '적금',
    '금',
    '외화',
    'CMA',
    '보험',
    '보증금',
    '자동차',
    '코인'
  ];

  var assetList = [
    '부동산',
    '분양권',
    '주식',
    '펀드',
    '채권',
    '연금저축',
    '예금',
    '청약저축',
    '적금',
    '금',
    '외화',
    'CMA',
    '보험',
    '보증금',
    '자동차',
    '코인'
  ];

  var debtList = [
    '주택담보대출',
    '전월세대출',
    '신용대출',
    '마이너스통장대출',
    '자동차할부대출',
    '신용카드현금대출',
    '신용카드할부원금',
    '휴대폰할부원금',
    '전월세보증금',
    '퍼스널론'
  ];

  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Asset input page'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 80,
                      height: 50,
                      child: DropdownButtonFormField(
                        key: _formStateKey1,
                        value: defaultAssetOrDebt,
                        items: assetOrDebt.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            defaultAssetOrDebt = value;
                            if (defaultAssetOrDebt == '자산') {
                              assetList = toggleBetweenAssetAndDebt;
                              defaultAsset = tollogDebtToAsset;
                            } else {
                              assetList = debtList;
                              defaultAsset = defaultDebt;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      height: 50,
                      child: DropdownButtonFormField(
                        key: _formStateKey2,
                        value: defaultAsset,
                        items: assetList.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            defaultAsset = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              if (defaultAssetOrDebt == '자산' && defaultAsset == '주식')
                StockInputPage(defaultAsset),
              if (defaultAssetOrDebt == '자산' && defaultAsset == '부동산')
                RealStateInputPage(defaultAsset),
              if (defaultAssetOrDebt == '자산' && defaultAsset == '예금')
                DepositInputPage(defaultAsset),
              if (defaultAssetOrDebt == '부채' && defaultAsset == '주택담보대출')
                DebtMortgagePage(defaultAsset),

            ],
          ),
        ));
  }
}
