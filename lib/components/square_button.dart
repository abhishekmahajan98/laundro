import 'package:flutter/material.dart';

import '../constants.dart';

class SquareButton extends StatelessWidget {
  final Function ontap; 
  final double marginL,marginR,marginT,marginB;
  final String imageRoute,buttonTag;
  

  SquareButton({
    @required this.ontap,
    @required this.imageRoute,
    @required this.buttonTag,
    @required this.marginL,
    @required this.marginT,
    @required this.marginR,
    @required this.marginB,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: double.infinity,
          margin: EdgeInsets.fromLTRB(marginL,marginT,marginR,marginB),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:0 ,bottom: 5),
                child: Image.asset(
                  imageRoute,
                  height: 1.5*(MediaQuery.of(context).size.height/10),
                  ),
              ),
              Text(
                buttonTag,
                style: kCategoryTextStyle,
                
                ),
            ],
          ),
        ),
      ),
    );
  }
}