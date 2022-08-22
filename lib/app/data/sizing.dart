import 'package:flutter/material.dart';

class Sizing {
  final widthDevice = 392.72727272727275;
  final heightDevice = 803.6363636363636;

  double widthS(int data, Size size) {
    double value = size.width * (data / widthDevice); // from 70
    return value;
  }

  double heightS(int data, Size size) {
    double value = size.height * (data / heightDevice); // from 70
    return value;
  }
}
