import 'dart:async';

import 'package:jsond_core/core.dart';

Future<T> watchdog<T>(FutureOr<T> Function() action) async {
  final s = Stopwatch()..start();
  try {
    return await action();
  } finally {
    s
      ..stop()
      ..elapsed.$debug();
  }
}
