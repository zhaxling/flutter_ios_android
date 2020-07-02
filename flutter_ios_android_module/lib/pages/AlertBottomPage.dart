import 'package:flutter/material.dart';

class AlertBottomWidget extends StatefulWidget {
  final List<String> items;
  final ValueChanged<int> chooseCallback;
  int chooseValue;

  AlertBottomWidget({this.items, this.chooseCallback, this.chooseValue});

  @override
  _AlertBottomWidgetState createState() => _AlertBottomWidgetState();
}

class _AlertBottomWidgetState extends State<AlertBottomWidget> {

  bool check = true;

//  var temp = chooseValue;

  // 通过widget拿到StatefulWidget参数


  List<Widget> itemsWidget(context) {
    List<Widget> list = new List();

//    for (int i = 0; i < items.length; i++) {
//      list.add(ListTile(
//        title: FlatButton(
//          child: Text(items[i]),
//          onPressed: () {
//            chooseCallback(i);
//          },
//        ),
//      ));
//      list.add(Divider(
//        height: 1,
//      ));
//    }

//    10001
//    00100
//    11011
//    10001
//
//
//    10101

    // 复选
    for (int i = 0; i < widget.items.length; i++) {
      var bit = 1 << widget.items.length - 1 - i;
      bool check = (widget.chooseValue & bit) > 0;
      list.add(_createCheckRow(widget.items[i],check, (){
          this.check = !check;
          if (check) {
            widget.chooseValue = widget.chooseValue & (~bit);
          } else {
            widget.chooseValue = widget.chooseValue ^ bit;
          }
      }));
      list.add(Divider(
        height: 1,
      ));
    }

    list.add(
      SizedBox(
        child: Container(
          color: Color(0xffEFEFF4),
        ),
        height: 8,
      ),
    );

    list.add(ListTile(
      title: FlatButton(
        child: Text('确定'),
        onPressed: () {
          widget.chooseCallback(widget.chooseValue);
          Navigator.pop(context);
        },
      ),
    ));
    return list;
  }

  Widget _createCheckRow(String title, bool check, Function tap) {
    return CheckboxListTile(
      title: Text(title),
      value: check,
      onChanged: (value) {
        setState(() {
          tap();
        });
      },
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: itemsWidget(context),
      ),
    );
  }
}
