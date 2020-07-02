import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

// ignore: must_be_immutable
class HuiZongAlertDialog extends Dialog {
  List showData;

  HuiZongAlertDialog({
    Key key,
    @required this.showData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _createContent(context);
  }

  Widget _createContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        // 保证半透明
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              margin: const EdgeInsets.all(12.0),
              child: new Column(
                children: <Widget>[
                  // 标题
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Center(
                      child: new Text(
                        "汇总",
                        style: new TextStyle(
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    color: Color(0xffe0e0e0),
                    height: 1.0,
                  ),
                  new Container(
                    // 设置最小高度
                    constraints: BoxConstraints(minHeight: 70.0),
                    child: new Padding(
                      padding: const EdgeInsets.only(left: 50, top: 10, right: 50, bottom: 15),
                      // IntrinsicHeight将其内部子元素的高度限制为其本身的高度
                      child: _createHuiZongContent(),
                    ),
                  ),
                  new Container(
                    color: Color(0xffe0e0e0),
                    height: 1.0,
                  ),
                  // 底部按钮
                  this._buildBottomButtonGroup(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 创建汇总内容
  Widget _createHuiZongContent() {
    List<Widget> list = List();
    for (Map obj in showData) {
      var row = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(obj["name"], style: TextStyle(fontSize: 16.0),),
          ),
          Text(obj["money"], style: TextStyle(fontSize: 16.0),),
        ],
      );
      list.add(row);
    }
    return Column(
      children: list,
    );
  }

  // 创建按钮
  Widget _buildBottomButtonGroup(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: GestureDetector(
        onTap: (){
          _onNavigationClickEvent(context);
        },
        child: Container(
//          margin: EdgeInsets.only(left: ScreenUtil().setWidth(25), right: ScreenUtil().setWidth(25),top: 15),
          height: ScreenUtil().setHeight(76),
          child: Center(
            child: Text("确定", style: TextStyle(fontSize: 18),),
          ),
        ),
      )
    );
  }

  /* 关闭 */
  void _onNavigationClickEvent(BuildContext context) {
    Navigator.pop(context); //关闭对话框
  }
}
