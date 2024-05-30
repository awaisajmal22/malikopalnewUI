import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:malikopal/utils/globles.dart';

import '../../ScopedModelWrapper.dart';

class AutoRollOverFeedBack extends StatelessWidget {
  const AutoRollOverFeedBack({Key? key, required this.upcomingClosing})
      : super(key: key);

  final String upcomingClosing;

  @override
  Widget build(BuildContext context) {
    AppModel model = ScopedModel.of<AppModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          "Auto Rollover",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(0xff1164AA),
          ),
        ),
        elevation: 0,
        leadingWidth: 1,
        backgroundColor: model.isDarkTheme ? Color(0xff6A6B6B) : Colors.white,
        actions: [
          InkWell(
            onTap: () {
              while (Navigator.canPop(knavigatorKey!.currentState!.context)) {
                Navigator.pop(knavigatorKey!.currentState!.context);
              }
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          while (Navigator.canPop(knavigatorKey!.currentState!.context)) {
            Navigator.pop(knavigatorKey!.currentState!.context);
          }
          return true;
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                InkWell(
                  onTap: () {
                    //

                    while (Navigator.canPop(
                        knavigatorKey!.currentState!.context)) {
                      Navigator.pop(knavigatorKey!.currentState!.context);
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(colors: [
                            // Color(0xff754399),
                            // Color(0xff7E4298),
                            // Color(0xff9B4297),
                            // Color(0xffAD4297),
                            // Color(0xffB44297),
                            Color(0xff254180),
                            Color(0xff1164AA),
                          ], tileMode: TileMode.repeated)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "RECEIPT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            "assets/newassets/tickIcon.png",
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Text(
                              "Your Closing Payment will be added in your Capital amount for next ${upcomingClosing} closing ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                )
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
