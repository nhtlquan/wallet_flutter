import 'package:flutter/material.dart';

import 'Helper/Constant.dart';
import 'ResourceUtil.dart';
typedef VoidOnAction = void Function();
enum ButtonWidgetType {
  buttonSelect,
  buttonSelectDisable,
  buttonUnSelect,
  buttonCancel,
  buttonRetry,
}

class ButtonWidget extends StatelessWidget {
  final VoidOnAction onTap;
  final String title;
  final double fontSize;
  final ButtonWidgetType buttonType;
  final double height;
  final bool isDropDown;

  ButtonWidget({this.onTap, this.title, this.fontSize = 16, this.buttonType = ButtonWidgetType.buttonSelect, this.height = 45, this.isDropDown = false});

  Color _colorTitle() {
    if (buttonType == ButtonWidgetType.buttonUnSelect) {
      return Constant.TEXTCOLOR_BLUE_2D;
    }
    if (buttonType == ButtonWidgetType.buttonCancel) {
      return Constant.TEXTCOLOR_BLACK_62;
    }

    return Colors.white;
  }

  BoxDecoration _boxDecoration() {
    if (buttonType == ButtonWidgetType.buttonUnSelect) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Constant.TEXTCOLOR_BLUE_2D, width: 1),
      );
    }
    if (buttonType == ButtonWidgetType.buttonCancel) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Constant.TEXTCOLOR_BLACK_9A, width: 1),
      );
    }
    if (buttonType == ButtonWidgetType.buttonRetry) {
      return BoxDecoration(
        color: ResourceUtil.hexToColor('dab868'),
        borderRadius: BorderRadius.circular(8),
      );
    }

    if (buttonType == ButtonWidgetType.buttonSelectDisable) {
      return BoxDecoration(
        color: Constant.TEXTCOLOR_BLACK_2B.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      );
    }
    return BoxDecoration(
      color: Constant.TEXTCOLOR_BLUE_2D,
      borderRadius: BorderRadius.circular(8),
    );
  }

  EdgeInsets _padding() {
    if (buttonType == ButtonWidgetType.buttonUnSelect) {
      return EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7);
    }
    if (buttonType == ButtonWidgetType.buttonCancel) {
      return EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7);
    }

    return EdgeInsets.only(left: 11, right: 11, top: 8, bottom: 8);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: _padding(),
        decoration: _boxDecoration(),
        alignment: Alignment.center,
        height: this.height,
        child: isDropDown
            ? Row(
                children: <Widget>[
                  Text(
                    title,
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _colorTitle(), fontSize: this.fontSize, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: _colorTitle(),
                  )
                ],
              )
            : Text(
                title,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(color: _colorTitle(), fontSize: this.fontSize, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
