import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowDialogDemo extends StatefulWidget {
  @override
  State<ShowDialogDemo> createState() => _ShowDialogDemoState();
}

class _ShowDialogDemoState extends State<ShowDialogDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('TextField Example'),
        // ),
        body: Center(
          child: TextField(
              // decoration: InputDecoration(
              //   hintText: 'Flutter TextField',
              // ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF6F8FB),
                hintText: 'Flutter TextField',
                hintStyle: const TextStyle(
                    fontSize: 16, color: Color(0x998588A9)),
                floatingLabelBehavior:
                FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.fromLTRB(16, 6, 1, 6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
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
