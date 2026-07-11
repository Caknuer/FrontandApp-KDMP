import 'package:flutter/material.dart';

import '../services/session_service.dart';

class IdleDetector extends StatefulWidget {

  final Widget child;
  final Duration timeout;
  final VoidCallback onTimeout;

  const IdleDetector({
    super.key,
    required this.child,
    required this.onTimeout,
    this.timeout = const Duration(minutes: 10),
  });

  @override
  State<IdleDetector> createState() => _IdleDetectorState();
}

class _IdleDetectorState extends State<IdleDetector> {

  @override
  void initState() {
    super.initState();

    SessionService.start(
      timeout: widget.timeout,
      onTimeout: widget.onTimeout,
    );
  }

  void _resetTimer() {

    SessionService.reset(
      timeout: widget.timeout,
      onTimeout: widget.onTimeout,
    );

  }

  @override
  void dispose() {

    SessionService.stop();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Listener(

      behavior: HitTestBehavior.translucent,

      onPointerDown: (_) => _resetTimer(),

      onPointerMove: (_) => _resetTimer(),

      onPointerSignal: (_) => _resetTimer(),

      child: widget.child,

    );

  }

}