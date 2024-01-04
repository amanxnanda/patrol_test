import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_test/main.dart';

void main() {
  patrolTest(
    'counter state is the same after going to home and switching apps',
    ($) async {
      // Replace later with your app's main widget
      await $.pumpWidgetAndSettle(const MainApp());

      await $(FloatingActionButton).tap();
      await $(FloatingActionButton).tap();
      await $(FloatingActionButton).tap();

      expect($('Count 3'), findsOneWidget);

      if (!Platform.isMacOS) {
        await $.native.pressHome();
        await $.native.pressRecentApps();
        await $.native.tap(
          Selector(
            text: 'patrol_test',
            resourceId: 'com.amannanda.patrol_test',
            pkg: 'com.amannanda.patrol_test',
          ),
        );

        await Future<void>.delayed(const Duration(seconds: 20));
      }
    },
  );
}
