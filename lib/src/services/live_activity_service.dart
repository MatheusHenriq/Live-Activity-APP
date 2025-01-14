import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';

class LiveActivityModel {
  final String carModel;
  final String driverCode;
  final int minutesToArrive;
  final int carArriveProgress;
  LiveActivityModel({
    required this.carModel,
    required this.driverCode,
    required this.minutesToArrive,
    required this.carArriveProgress,
  });

  Map<String, dynamic> toJson() => {
        'carModel': carModel,
        'driverCode': driverCode,
        'minutesToArrive': minutesToArrive,
        'carArriveProgress': carArriveProgress,
      };
}

class LiveActivityService {
  static const platform = MethodChannel('liveActivityChannel');
  static const listenerChannel = EventChannel('LiveActivityEvents');
  StreamSubscription? eventSubscription;

  Future<void> listener() async {
    eventSubscription = listenerChannel.receiveBroadcastStream().listen(
      (event) async {
        switch (event['eventType']) {
          case 'pushToStartToken':
            dynamic tokenValue = event['value'];
            log("pushToStartToken -> $tokenValue");
            break;
          case 'pushToUpdateToken':
            dynamic tokenValue = event['value'];

            log("pushToUpdateToken -> $tokenValue");
            break;
        }
      },
    );
  }

  static Future<void> requestPushNotificationPermission() async {
    try {
      await platform.invokeMethod("requestForNotificationPermission");
    } on PlatformException catch (e) {
      throw PlatformException(message: e.message, code: e.code);
    }
  }

  static Future<void> registerDevice() async {
    try {
      await platform.invokeMethod("registerDevice");
    } on PlatformException catch (e) {
      throw PlatformException(message: e.message, code: e.code);
    }
  }

  Future<void> startLiveActivity({required LiveActivityModel data}) async {
    try {
      await platform.invokeMethod(
        'startLiveActivity',
        data.toJson(),
      );
    } on PlatformException catch (e) {
      log("Failed to start live activity: '${e.message}'.");
    }
  }

  Future<void> updateLiveActivity({required LiveActivityModel data}) async {
    try {
      await platform.invokeMethod(
        'updateLiveActivity',
        data.toJson(),
      );
    } on PlatformException catch (e) {
      log("Failed to start live activity: '${e.message}'.");
    }
  }

  Future<void> endLiveActivity() async {
    try {
      await platform.invokeMethod(
        'endLiveActivity',
      );
    } on PlatformException catch (e) {
      log("Failed to start live activity: '${e.message}'.");
    }
  }
}
