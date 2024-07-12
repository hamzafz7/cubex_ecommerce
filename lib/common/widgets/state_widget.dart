import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateWidget extends StatelessWidget {
  const StateWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text.tr));
  }
}
