import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DebtMortgagePage extends StatelessWidget {
  String? debtTypeTemp;
  DebtMortgagePage(this.debtTypeTemp);

  final format = DateFormat("yyyy-MM-dd");

  var _bankNamePriceController = TextEditingController();
  var _debtNameController = TextEditingController();
  var _totalPriceController = TextEditingController();
  var _interestRatePriceController = TextEditingController();
  var _returnYearController = TextEditingController();
  var _returnMethodController = TextEditingController();
  var _startDateController = TextEditingController();
  var _endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _bankNamePriceController,
              decoration: InputDecoration(
                hintText: '',
                labelText: '은행명',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _debtNameController,
              decoration: InputDecoration(
                hintText: '',
                labelText: '담보명',
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _totalPriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '담보설정액',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _interestRatePriceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '이자율',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _returnYearController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '',
              labelText: '상환기간',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _returnMethodController,
            decoration: InputDecoration(
              hintText: '',
              labelText: '상환방법',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DateTimeField(
            controller: _startDateController ,
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
            controller: _endDateController ,
            decoration: InputDecoration(
              hintText: '',
              labelText: '종료일',
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
            onPressed: () => saveDebt(),
            child: Text('저장하기')
        ),
      ],
    );
  }
  void saveDebt() {

    final debtType = debtTypeTemp;
    final bankName = _bankNamePriceController.text;
    final debtName = _debtNameController.text;
    final totalPrice = int.parse(_totalPriceController.text);
    final interestRate = double.parse(_interestRatePriceController.text);
    final returnYear = int.parse(_returnYearController.text);
    final returnMethod = _returnMethodController.text;
    final startDate = DateTime.parse(_startDateController.text);
    final endDate = DateTime.parse(_endDateController.text);

    FirebaseFirestore.instance.collection('debtList').add({
      'debtType': debtType,
      'bankName': bankName,
      'debtName': debtName,
      'totalPrice': totalPrice,
      'interestRate': interestRate,
      'returnYear': returnYear,
      'returnMethod': returnMethod,
      'startDate': startDate,
      'endDate': endDate,
    });

    _bankNamePriceController.clear();
    _debtNameController.clear();
    _totalPriceController.clear();
    _interestRatePriceController.clear();
    _returnYearController.clear();
    _returnMethodController.clear();
    _startDateController.clear();
    _endDateController.clear();

  }
}
