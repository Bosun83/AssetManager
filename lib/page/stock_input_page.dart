import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockInputPage extends StatelessWidget {
  String? assetTypeTemp;
  StockInputPage(this.assetTypeTemp);

  final format = DateFormat("yyyy-MM-dd");

  var _assetNameController = TextEditingController();
  var _amountController = TextEditingController();
  var _averagePriceController = TextEditingController();
  var _currentPriceController = TextEditingController();
  var _targetPriceController = TextEditingController();
  var _boughtDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _assetNameController,
            decoration: InputDecoration(
              hintText: '주식 종목명',
              labelText: '종목명',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '주식수',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _averagePriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '평균구입가',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _currentPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '현재가',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _targetPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '목표가',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DateTimeField(
            controller: _boughtDateController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '구입일',
            ),
            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
            },
          ),
        ),
        ElevatedButton(
            onPressed: () => saveAsset(),
            child: Text('저장하기')
        ),
      ],
    );
  }
  void saveAsset() {
    final assetType = assetTypeTemp;
    final assetName = _assetNameController.text;
    final amount = int.parse(_amountController.text);
    final averagePrice = int.parse(_averagePriceController.text);
    final currentPrice = int.parse(_currentPriceController.text);
    final targetPrice = int.parse(_targetPriceController.text);
    final boughtDate = DateTime.parse(_boughtDateController.text);

    FirebaseFirestore.instance.collection('AssetList').add({
      'assetType': assetType,
      'assetName': assetName,
      'amount': amount,
      'averagePrice': averagePrice,
      'currentPrice': currentPrice,
      'targetPrice': targetPrice,
      'boughtDate': boughtDate,
      'evaluatedValue': amount * currentPrice,
    });
    _assetNameController.clear();
    _amountController.clear();
    _averagePriceController.clear();
    _currentPriceController.clear();
    _targetPriceController.clear();
    _boughtDateController.clear();

  }
}
