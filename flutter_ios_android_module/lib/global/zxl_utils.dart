
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';

/* 打印设备信息 */
void printScreenInformation(BuildContext context) {

  ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

  print('Device width px:${ScreenUtil.screenWidth}'); //Device width
  print('Device height px:${ScreenUtil.screenHeight}'); //Device height
  print(
      'Device pixel density:${ScreenUtil.pixelRatio}'); //Device pixel density
  print(
      'Bottom safe zone distance dp:${ScreenUtil.bottomBarHeight}'); //Bottom safe zone distance，suitable for buttons with full screen
  print(
      'Status bar height px:${ScreenUtil.statusBarHeight}dp'); //Status bar height , Notch will be higher Unit px
  print(
      'Ratio of actual width dp to design draft px:${ScreenUtil().scaleWidth}');
  print(
      'Ratio of actual height dp to design draft px:${ScreenUtil().scaleHeight}');
  print(
      'The ratio of font and width to the size of the design:${ScreenUtil().scaleWidth * ScreenUtil.pixelRatio}');
  print(
      'The ratio of  height width to the size of the design:${ScreenUtil().scaleHeight * ScreenUtil.pixelRatio}');
}
