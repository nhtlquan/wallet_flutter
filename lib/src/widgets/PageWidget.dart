import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DialogLoading.dart';

typedef VoidOnBackPress = Function();
typedef VoidRefreshData = Function();

class PageWidget extends StatefulWidget {
  final Widget child;
  final Widget appBar;
  final Stream streamLoading;
  final bool isBackPage;
  final Widget bottomNavigationBar;
  final VoidOnBackPress onBackPress;
  final VoidRefreshData voidRefreshData;
  final bool resizeToAvoidBottomPadding;

  PageWidget({this.streamLoading, this.child, this.appBar, this.bottomNavigationBar, this.voidRefreshData, this.isBackPage = true, this.onBackPress, this.resizeToAvoidBottomPadding = false});

  @override
  _PageWidgetState createState() => new _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> with WidgetsBindingObserver {
  var loading = DialogLoading();
  var isShowLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child,
        );
      },
      home: WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Scaffold(
                appBar: this.widget.appBar,
                backgroundColor: Colors.white,
                resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
                body: this.widget.child,
                bottomNavigationBar: this.widget.bottomNavigationBar != null ? this.widget.bottomNavigationBar : SizedBox(),
              ),
              StreamBuilder(
                stream: widget.streamLoading,
                builder: (context, snapshot) {
                  isShowLoading = snapshot.hasData ? snapshot.data : false;
                  return isShowLoading ? loading : SizedBox();
                },
              )
            ],
          ),
        ),
      ),
      theme: ThemeData(
        textTheme: TextTheme(body1: TextStyle(color: Colors.black)),
        platform: TargetPlatform.iOS,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
      ),
    );
    print("abc");
  }

  Future<bool> _onBackPressed() {
    if (this.widget.onBackPress != null) {
      this.widget.onBackPress();
    }
    if (isShowLoading) {
      return Future.value(false);
    } else {
      return Future.value(this.widget.isBackPage);
    }
  }
}
