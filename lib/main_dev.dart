import 'package:booksharing/config/flavor_config.dart';
// import 'package:booksharing/core/viewModels/bloc/profile_bloc_delegate.dart';
// import 'package:booksharing/locator.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // run app if and if only device in protrait mode not landscape mode
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then((_) {
  // WidgetsFlutterBinding.ensureInitialized();

  //  get the shared preference instance
  // var path = Directory.current.path;
  // Hive
  //   ..init(path)
  //   ..registerAdapter(StudentAdapter());
  // await Hive.initFlutter();
  // await Hive.openBox('Student');
  // await Hive.openBox('DarkTheme');
  FlavorConfig(flavor: Flavor.QA);
  // setupLocator();
  // BlocSupervisor.delegate = locator<SimpleBlocDelegate>();

  runApp(QAWidget());

  // });
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
