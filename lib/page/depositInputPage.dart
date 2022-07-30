import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepositInputPage extends StatelessWidget {
  String? assetTypeTemp;
  DepositInputPage(this.assetTypeTemp);

  final format = DateFormat("yyyy-MM-dd");

  var _assetNameController = TextEditingController();
  var _startDateController = TextEditingController();
  var _endDateController = TextEditingController();
  var _principalController = TextEditingController();
  var _interestRateController = TextEditingController();

  void saveAsset() {
    final assetType = assetTypeTemp;
    final assetName = _assetNameController.text;
    final startDate = DateTime.parse(_startDateController.text);
    final endDate = DateTime.parse(_endDateController.text);
    final principal = int.parse(_principalController.text);
    final interestRate = double.parse(_interestRateController.text);

    FirebaseFirestore.instance.collection('AssetList').add({
      'assetType': assetType,
      'assetName': assetName,
      'startDate': startDate,
      'endDate': endDate,
      'principal': principal,
      'interestRate': interestRate,
    });
    _assetNameController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _principalController.clear();
    _interestRateController.clear();

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
              labelText: '상품명',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DateTimeField(
            controller: _startDateController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '시작일',
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
          child: DateTimeField(
            controller: _endDateController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '만기일',
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
            controller: _principalController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '투자원금',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _interestRateController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '이자율',
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
