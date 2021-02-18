import 'package:booksharing/config/flavor_config.dart';
import 'package:booksharing/core/constant/app_constant.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(flavor: Flavor.QA);

  runApp(QAWidget());
}

class QAWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dev Testing",
      home: Scaffold(
        body: Center(
          child: Text("This is Development Screens"),
        ),
      ),
    );
  }
}
