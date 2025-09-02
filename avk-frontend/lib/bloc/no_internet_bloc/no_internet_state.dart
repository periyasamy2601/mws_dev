part of 'no_internet_bloc.dart';

/// The initial state when the bloc is first created.
@immutable
sealed class NoInternetState {}

/// The initial state when the bloc is first created.
/// No connectivity check has been performed yet.
final class NoInternetInitial extends NoInternetState {}

/// State when no internet connection is detected.
final class InternetDisconnected extends NoInternetState {}

/// State when internet connection is available/restored.
final class InternetConnected extends NoInternetState {}
