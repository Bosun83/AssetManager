import 'package:flutter/material.dart';

Widget bottomPage () {
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        label: '머니',
        icon: Icon(Icons.home),
      ),
      BottomNavigationBarItem(
        label: '목표',
        icon: Icon(Icons.money),
      ),
      BottomNavigationBarItem(
        label: '습관',
        icon: Icon(Icons.hail_outlined),
      ),
    ],
  );
}