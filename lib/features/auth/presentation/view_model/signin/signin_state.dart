part of 'signin_cubit.dart';

@immutable
sealed class SigninState {}

final class SigninInitialState extends SigninState {}
final class SigninLoadingState extends SigninState {}
final class SigninSuccessState extends SigninState {}
final class SigninFailureState extends SigninState {}
