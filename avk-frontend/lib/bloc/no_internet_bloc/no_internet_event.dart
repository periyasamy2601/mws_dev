part of 'no_internet_bloc.dart';

/// Triggered when there is a change in internet connectivity state.
@immutable
sealed class NoInternetEvent {}

/// Triggered when there is a change in internet connectivity state.
///
/// Typically used when the connectivity listener reports back.
final class NoInterNetCallbackEvent extends NoInternetEvent {
  NoInterNetCallbackEvent({required this.connectivityResult});

  final ConnectivityResult connectivityResult;
}
