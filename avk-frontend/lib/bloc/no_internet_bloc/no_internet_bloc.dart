import 'dart:async';
import 'package:avk/core/helper/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'no_internet_event.dart';
part 'no_internet_state.dart';

/// BLoC that listens to internet connectivity changes
/// and emits [InternetConnected] or [InternetDisconnected] states accordingly.
class NoInternetBloc extends Bloc<NoInternetEvent, NoInternetState> {

  /// Constructor: Initializes the bloc and sets up the connectivity listener
  NoInternetBloc() : super(NoInternetInitial()) {
    // Register handler for connectivity event
    on<NoInterNetCallbackEvent>(_onNoInterNetCallbackEvent);

    // Listen to connectivity changes and add an event to the bloc
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> status) {
      // Emit an event to the bloc with the new connectivity status
      add(NoInterNetCallbackEvent(connectivityResult: status.first));
    });
  }

  /// Tracks whether the current internet state is disconnected
  bool internetStateIsDisconnect = false;

  /// Subscription to the connectivity change stream
  late final StreamSubscription _connectivitySubscription;

  /// Handles connectivity change events and emits the appropriate state
  FutureOr<void> _onNoInterNetCallbackEvent(
      NoInterNetCallbackEvent event, Emitter<NoInternetState> emit) {
    // Update the local flag based on the connectivity result
    internetStateIsDisconnect = event.connectivityResult == ConnectivityResult.none;

    // Log the current connectivity status (for debugging purposes)
    logger.debugLog('internetStateIsDisconnect', internetStateIsDisconnect);

    // Emit the appropriate state based on connectivity
    if (internetStateIsDisconnect) {
      emit(InternetDisconnected());
    } else {
      emit(InternetConnected());
    }
  }

  /// Clean up: cancel the stream subscription to avoid memory leaks
  @override
  Future<void> close() async {
    await _connectivitySubscription.cancel();
    return super.close();
  }
}
