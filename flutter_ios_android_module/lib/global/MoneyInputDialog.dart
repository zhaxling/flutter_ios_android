import 'dart:ffi';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MoneyInputDialog extends Dialog {
  String title;
  String negativeText;
  String positiveText;
  Function onCloseEvent;
  ValueChanged<String> onPositivePressEvent;

  MoneyInputDialog({
    Key key,
    @required this.title,
    this.negativeText,
    this.positiveText,
    this.onPositivePressEvent,
    @required this.onCloseEvent,
  }) : super(key: key);

  // 输入框
  TextEditingController _editingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _onNavigationClickEvent(context);
        return Future.value(false);
      },
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                _onNavigationClickEvent(context);
              },
            ),
            _createContent(context), //构建具体的对话框布局内容
          ],
        ),
      ),
    );
//    return _createContent(context);
  }

  Widget _createContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Material(
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
                        title,
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
                      padding: const EdgeInsets.all(12.0),
                      // IntrinsicHeight将其内部子元素的高度限制为其本身的高度
                      child: new IntrinsicHeight(
                        // 输入框
                          child: TextField(
                            controller: _editingController,
                            // 键盘类型
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            focusNode: _focusNode,
                            // 自动获取焦点
                            autofocus: true,
                            cursorColor: Colors.orange,
                            // 占位
                            decoration: InputDecoration(
                              // labelText: '金额',
                              hintText: '请输入金额',
                              border: InputBorder.none,
                              // 图标
                              prefixIcon: Icon(IconData(
                                //code
                                  0xf157,
                                  //字体
                                  fontFamily: 'MyFlutterApp'),
                                color: Colors.orange,
                              ),
                            ),
                            // 监听文本变化
                            onChanged: (v) {
                              print('onChanged：$v');
                            },
                          )
                      ),
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

  // 创建按钮
  Widget _buildBottomButtonGroup(BuildContext context) {

    FocusScope.of(context).requestFocus(_focusNode);     // 获取焦点

    var widgets = <Widget>[];
    if (negativeText != null && negativeText.isNotEmpty)
      widgets.add(_buildBottomCancelButton(context));
    if (positiveText != null && positiveText.isNotEmpty) {
      if (widgets.length > 0) {
        widgets.add(Container(
          color: Color(0xffe0e0e0),
          width: 1.0,
          height: 56,
        ),);
      }
      widgets.add(_buildBottomPositiveButton(context));
    }
    return Padding(
      padding: EdgeInsets.all(0),
      child: Flex(
        direction: Axis.horizontal,
        children: widgets,
      ),
    );
  }

  // 取消按钮
  Widget _buildBottomCancelButton(BuildContext context) {
    return new Flexible(
      fit: FlexFit.tight,
      child: new FlatButton(
        onPressed: (){
          _focusNode.unfocus();
          onCloseEvent();
          Navigator.pop(context); //关闭对话框
        },
        child: new Text(
          negativeText,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  // 确定按钮
  Widget _buildBottomPositiveButton(BuildContext context) {
    return new Flexible(
      fit: FlexFit.tight,
      child: new FlatButton(
        onPressed: () {
          _focusNode.unfocus();
          onPositivePressEvent(_editingController.text);
          Navigator.pop(context); //关闭对话框
        },
        child: new Text(
          positiveText,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  /* 关闭 */
  void _onNavigationClickEvent(BuildContext context) {
    Navigator.pop(context); //关闭对话框
  }
}
