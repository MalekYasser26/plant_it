part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class SigninInitialState extends AuthState {}
final class SigninLoadingState extends AuthState {}
final class SigninSuccessState extends AuthState {}
final class SigninFailureState extends AuthState {}
final class SignupInitialState extends AuthState {}
final class SignupSuccessState extends AuthState {}
final class SignupLoadingState extends AuthState {}
final class SignupFailureState extends AuthState {}
final class AuthUpdatedState extends AuthState {}
final class AuthAuthenticatedState extends AuthState {}

