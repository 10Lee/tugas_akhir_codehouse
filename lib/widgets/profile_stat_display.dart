import 'package:flutter/material.dart';
import 'package:tugas_akhir_stenly_rachmad/config/dimensions.dart';

class ProfileStatDisplay extends StatelessWidget {
  late String title;
  late Widget child;

  ProfileStatDisplay({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width170,
      height: Dimensions.height170,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title',
            style: TextStyle(fontSize: 20.0, color: Colors.lightBlue.shade300),
          ),
          SizedBox(height: Dimensions.height10),
          child,
        ],
      ),
    );
  }
}
