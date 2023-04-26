import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../constants/responsive.dart';
import 'analytic_cards.dart';
import 'custom_appbar.dart';
import 'discussions.dart';

class DashBoardContent extends StatelessWidget {
  const DashBoardContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      padding: EdgeInsets.all(appPadding),
      child: Column(
        children: [
          CustomAppbar(),
          SizedBox(height: appPadding,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              Expanded(
                flex: 5,
                child: AnalyticCards(),
              ),
              if(!Responsive.isMobile(context))
                SizedBox(
                  width: appPadding,
                ),
              if(!Responsive.isMobile(context))
              Expanded(
                flex: 2,
                child: Discussions(),
              ),
            ],
          ),
        ],
      ),
    ),
    );

  }
}