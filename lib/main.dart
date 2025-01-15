import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_activity_flutter/src/services/live_activity_service.dart';
import 'package:live_activity_flutter/src/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LiveActivityService.requestPushNotificationPermission()
      .then((value) async {
    await LiveActivityService.registerDevice();
    await LiveActivityService().listener();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'L',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pinkAccent,
      ),
      home: HomeView(),
    );
  }
}
