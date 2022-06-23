import 'package:cofredesenha/utils/images.dart';
import 'package:cofredesenha/utils/styles.dart';
import 'package:cofredesenha/utils/textStyle.dart';
import 'package:flutter/material.dart';

class EmpryRefund extends StatefulWidget {
  const EmpryRefund({Key? key}) : super(key: key);

  @override
  State<EmpryRefund> createState() => _EmpryRefundState();
}

class _EmpryRefundState extends State<EmpryRefund> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Column(
        children: [
          Center(
              child: Image.asset(
                DefaultAssets.emptyDependents,
                height: 250,
              )),
          // SizedBox(height: 80,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nenhuma senha cadastrada!",
                style: DefaultStyle.textStyle(
                    fontWeight: FontWeight.w700,
                    color: DefaultColors.darkColor2,
                    size: 24),
              )
            ],
          ),
        ],
      ),
    );;
  }
}