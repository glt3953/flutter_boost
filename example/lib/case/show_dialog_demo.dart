import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDialogDemo extends StatefulWidget {
  @override
  State<ShowDialogDemo> createState() => _ShowDialogDemoState();
}

class _ShowDialogDemoState extends State<ShowDialogDemo> {
  @override
  final GlobalKey _scaffoldKey = GlobalKey();
  double _containerHeight = 0;

  double _getContainerHeight() {
    final RenderBox renderBox = _scaffoldKey.currentContext?.findRenderObject() as RenderBox;
    double newHeight = renderBox.size.height;
    if (newHeight != _containerHeight) {
      _containerHeight = newHeight;
      print("_containerHeight Height: ${_containerHeight}");
    }

    return _containerHeight;
  }

  Widget build(BuildContext context) {
    print('flutter build');

          return Scaffold(
            backgroundColor: Colors.red,
            // appBar: AppBar(
            //   title: Text('TextField Example'),
            // ),
            body: Column(
              children: [
                Container(
                  key: _scaffoldKey,
              child: TextField(
                  // key: _scaffoldKey,
                  // expands: true,
                  maxLines: 150,
                  minLines: 1,
                  onChanged: (text) {
                    _getContainerHeight();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF6F8FB),
                    hintText: 'Flutter TextField',
                    hintStyle: const TextStyle(
                        fontSize: 16, color: Color(0x998588A9)),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding:
                    //     EdgeInsets.all(20),
                    // isCollapsed: true,
                    const EdgeInsets.fromLTRB(16, 6, 1, 6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                ),
              ],
            ),
          );

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        // appBar: AppBar(
        //   title: Text('TextField Example'),
        // ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints.tight(constraints.biggest),
                child: Container(
                        height: _containerHeight,
                        // child: Expanded(
                        child: TextField(
                          expands: true,
                          maxLines: null,
                          minLines: null,
                          onChanged: (text) {
                            if (context.size != null) {
                              _containerHeight = context.size!.height;
                            }
                            print('TextField height:${_containerHeight}');

                            // setState(() {
                            //   // 获取 TextField 的高度
                            //   if (context.size != null) {
                            //     _containerHeight = context.size!.height;
                            //   }
                            //   print('TextField height:${_containerHeight}');
                            // });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF6F8FB),
                            hintText: 'Flutter TextField',
                            hintStyle: const TextStyle(
                                fontSize: 16, color: Color(0x998588A9)),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding:
                                const EdgeInsets.fromLTRB(16, 6, 1, 6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      // )
                ),
              );
            },
          )
        ),
      );

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('showDialog Demo'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      _showMaterialDialog();
                    },
                    child: Text('Show Material Dialog'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showCupertinoDialog();
                    },
                    child: Text('Show Cupertino Dialog'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showSimpleDialog();
                    },
                    child: Text('Show Simple Dialog'),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context)
                        .pop({'msg': 'I am from *showDialog demo* ...'}),
                    child: Text('Pop with parameter'),
                  ),
                ],
              ),
            )));
  }

  void _showMaterialDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Material Dialog'),
            content: Text('Hey! I am `showDialog` demo!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Close')),
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  void _showCupertinoDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Cupertino Dialog'),
            content: Text('Hey! I am `showDialog` demo!'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Close')),
            ],
          );
        });
  }

  void _showSimpleDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (context) {
          return SimpleDialog(
            title: Text('Chosse an Option'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  _dismissDialog();
                },
                child: const Text('Option 1'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  _dismissDialog();
                },
                child: const Text('Option 2'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  _dismissDialog();
                },
                child: const Text('Option 3'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  _dismissDialog();
                },
                child: const Text('Option 4'),
              ),
            ],
          );
        });
  }
}
