import 'dart:async';

class SessionService {

  static Timer? _timer;

  static void start({

    required Duration timeout,

    required Function() onTimeout,

  }) {

    _timer?.cancel();

    _timer = Timer(

      timeout,

      onTimeout,

    );

  }

  static void reset({

    required Duration timeout,

    required Function() onTimeout,

  }) {

    _timer?.cancel();

    _timer = Timer(

      timeout,

      onTimeout,

    );

  }

  static void stop() {

    _timer?.cancel();

  }

}