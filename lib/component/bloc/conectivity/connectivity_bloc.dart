
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  StreamSubscription subscription;

  @override
  ConnectivityState get initialState => AppStarted();

  @override
  Future<Function> close() {
    subscription.cancel();
    return super.close();
  }

  @override
  Stream<Transition<ConnectivityEvent, ConnectivityState>> transformEvents(
      Stream<ConnectivityEvent> events,
      TransitionFunction<ConnectivityEvent, ConnectivityState> next) {
    return super.transformEvents(
      events.debounceTime(
        const Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) {
    final ConnectivityState currentState = state;

    if (currentState is AppStarted) {
      subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult connectivityResult) {
        if (connectivityResult == ConnectivityResult.mobile) {
          InternetAvailable();
          return true;
        } else if (connectivityResult == ConnectivityResult.wifi) {
          InternetAvailable();
          return true;
        } else {
          InternetUnavailable();
          return false;
        }
      });
    }
  }
}
