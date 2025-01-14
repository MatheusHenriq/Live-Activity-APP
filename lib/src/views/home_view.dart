import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_activity_flutter/src/services/live_activity_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('iOS Live Notification'),
        backgroundColor: Colors.pinkAccent,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            spacing: 24,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton.filled(
                disabledColor: Colors.pinkAccent,
                child: const Text("Start Live Activity"),
                onPressed: () async {
                  LiveActivityService().startLiveActivity(
                      data: LiveActivityModel(
                    carModel: "Corolla",
                    driverCode: "XJUAKF",
                    minutesToArrive: 10,
                    carArriveProgress: 0,
                  ));
                },
              ),
              CupertinoButton.filled(
                disabledColor: Colors.pinkAccent,
                child: const Text("Update Live Activity- 25%"),
                onPressed: () async {
                  LiveActivityService().updateLiveActivity(
                      data: LiveActivityModel(
                    carModel: "Corolla",
                    driverCode: "XJUAKF",
                    minutesToArrive: 7,
                    carArriveProgress: 25,
                  ));
                },
              ),
              CupertinoButton.filled(
                disabledColor: Colors.pinkAccent,
                child: const Text("Update Live Activity - 50%"),
                onPressed: () async {
                  LiveActivityService().updateLiveActivity(
                      data: LiveActivityModel(
                    carModel: "Corolla",
                    driverCode: "XJUAKF",
                    minutesToArrive: 5,
                    carArriveProgress: 50,
                  ));
                },
              ),
              CupertinoButton.filled(
                disabledColor: Colors.pinkAccent,
                child: const Text("Update Live Activity - 75%"),
                onPressed: () async {
                  LiveActivityService().updateLiveActivity(
                      data: LiveActivityModel(
                    carModel: "Corolla",
                    driverCode: "XJUAKF",
                    minutesToArrive: 2,
                    carArriveProgress: 75,
                  ));
                },
              ),
              CupertinoButton.filled(
                disabledColor: Colors.pinkAccent,
                child: const Text("Update Live Activity - 100%"),
                onPressed: () async {
                  LiveActivityService().updateLiveActivity(
                      data: LiveActivityModel(
                    carModel: "Corolla",
                    driverCode: "XJUAKF",
                    minutesToArrive: 0,
                    carArriveProgress: 100,
                  ));
                },
              ),
              CupertinoButton.filled(
                disabledColor: Colors.pinkAccent,
                child: const Text("End Live Activity"),
                onPressed: () async {
                  LiveActivityService().endLiveActivity();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
