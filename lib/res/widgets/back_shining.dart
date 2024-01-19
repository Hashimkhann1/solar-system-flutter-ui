import 'package:flutter/material.dart';

class BackShining extends StatelessWidget {
  double backHeight = 0.0;
  BackShining({super.key,required this.backHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: backHeight,
      width: MediaQuery.of(context).size.width * 0.99,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xff1d3c7d),
            spreadRadius: 0,
            blurRadius: 130,
            offset: Offset(0,3)
          ),
          BoxShadow(
            color: Color(0xff1d3c7d),
            spreadRadius: 0,
            blurRadius: 130,
            offset: Offset(0,3)
          ),
          BoxShadow(
            color: Color(0xff1d3c7d),
            spreadRadius: 0,
            blurRadius: 130,
            offset: Offset(0,3)
          ),
        ]
      ),
    );
  }
}
