// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:developer';
import 'dart:isolate';

import 'package:meta/meta.dart';

typedef ComputeCallback<Q, R> = FutureOr<R> Function(Q message);

/// The dart:io implementation of [isolate.compute].
Future<R> compute<Q, R>(ComputeCallback<Q, R> callback, Q message,
    {String debugLabel}) async {
  final Flow flow = Flow.begin();
  Timeline.startSync('$debugLabel: start', flow: flow);
  final ReceivePort resultPort = ReceivePort();
  final ReceivePort errorPort = ReceivePort();
  Timeline.finishSync();
  final Isolate isolate =
      await Isolate.spawn<_IsolateConfiguration<Q, FutureOr<R>>>(
    _spawn,
    _IsolateConfiguration<Q, FutureOr<R>>(
      callback,
      message,
      resultPort.sendPort,
      debugLabel,
      flow.id,
    ),
    errorsAreFatal: true,
    onExit: resultPort.sendPort,
    onError: errorPort.sendPort,
  );
  final Completer<R> result = Completer<R>();
  errorPort.listen((dynamic errorData) {
    assert(errorData is List<dynamic>);
    assert(errorData.length == 2);
    final Exception exception = Exception(errorData[0]);
    final StackTrace stack = StackTrace.fromString(errorData[1]);
    if (result.isCompleted) {
      Zone.current.handleUncaughtError(exception, stack);
    } else {
      result.completeError(exception, stack);
    }
  });
  resultPort.listen((dynamic resultData) {
    assert(resultData == null || resultData is R);
    if (!result.isCompleted) {
      result.complete(resultData);
    }
  });
  await result.future;
  Timeline.startSync('$debugLabel: end', flow: Flow.end(flow.id));
  resultPort.close();
  errorPort.close();
  isolate.kill();
  Timeline.finishSync();
  return result.future;
}

@immutable
class _IsolateConfiguration<Q, R> {
  const _IsolateConfiguration(
    this.callback,
    this.message,
    this.resultPort,
    this.debugLabel,
    this.flowId,
  );
  final ComputeCallback<Q, R> callback;
  final Q message;
  final SendPort resultPort;
  final String debugLabel;
  final int flowId;

  R apply() => callback(message);
}

Future<void> _spawn<Q, R>(
    _IsolateConfiguration<Q, FutureOr<R>> configuration) async {
  R result;
  await Timeline.timeSync(
    '${configuration.debugLabel}',
    () async {
      result = await configuration.apply();
    },
    flow: Flow.step(configuration.flowId),
  );
  Timeline.timeSync(
    '${configuration.debugLabel}: returning result',
    () {
      configuration.resultPort.send(result);
    },
    flow: Flow.step(configuration.flowId),
  );
}
