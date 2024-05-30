import 'package:flutter/material.dart';

dp({msg, arg}) => debugPrint(" \n $msg   $arg  ");

class AllRollOverTests extends StatefulWidget {
  const AllRollOverTests({Key? key}) : super(key: key);

  @override
  State<AllRollOverTests> createState() => _AllRollOverTestsState();
}

class _AllRollOverTestsState extends State<AllRollOverTests> {
  //

  TextEditingController controller = TextEditingController();

  TextEditingController controller2 = TextEditingController();

  int valueOne = 200;

  int send = 0;

  int remaing = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ses")),
      body: Column(
        children: [
          //
          TextField(
            controller: controller,
            onChanged: (value) {
              //
              if (value.isEmpty) {
                controller2.text = valueOne.toString();
                return;
              }
              controller2.text = (valueOne - int.parse(value)).toString();

              //
            },
          ),

          SizedBox(
            height: 40,
          ),

          TextField(
            controller: controller2,
            onChanged: (value) {
              //
              if (value.isEmpty) {
                controller.text = valueOne.toString();
                return;
              }
              controller.text = (valueOne - int.parse(value)).toString();
              //
            },
          ),

          //s
        ],
      ),
    );
  }
}
