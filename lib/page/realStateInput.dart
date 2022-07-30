import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RealStateInputPage extends StatelessWidget {
  String? assetTypeTemp;
  RealStateInputPage(this.assetTypeTemp);

  final format = DateFormat("yyyy-MM-dd");

  var _assetNameController = TextEditingController();
  var _boughtPriceController = TextEditingController();
  var _actualPriceController = TextEditingController();
  var _targetPriceController = TextEditingController();
  var _boughtDateController = TextEditingController();
  var _livingTypeController = TextEditingController();

  void saveAsset() {
    final assetType = assetTypeTemp;
    final assetName = _assetNameController.text;
    final boughtPrice = int.parse(_boughtPriceController.text);
    final actualPrice = int.parse(_actualPriceController.text);
    final targetPrice = int.parse(_targetPriceController.text);
    final boughtDate = DateTime.parse(_boughtDateController.text);
    final livingType = _livingTypeController.text;

    FirebaseFirestore.instance.collection('AssetList').add({
      'assetType': assetType,
      'assetName': assetName,
      'boughtPrice': boughtPrice,
      'actualPrice': actualPrice,
      'targetPrice': targetPrice,
      'boughtDate': boughtDate,
      'livingType': livingType,
      'evaluatedValue': actualPrice,
    });
    _assetNameController.clear();
    _boughtPriceController.clear();
    _actualPriceController.clear();
    _targetPriceController.clear();
    _boughtDateController.clear();
    _livingTypeController.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _assetNameController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '부동산명',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _boughtPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '구입가',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _actualPriceController,
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
              labelText: '매매호가',
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _livingTypeController,
            decoration: InputDecoration(
              hintText: '매매 전세 월세',
              labelText: '주거형태',
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () => saveAsset(),
            child: Text('저장하기')
        ),
      ],
    );
  }
}
