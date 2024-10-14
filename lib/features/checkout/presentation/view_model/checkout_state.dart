part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}
final class CheckoutLoadingState extends CheckoutState {}
final class CheckoutSuccessfulState extends CheckoutState {}
final class CheckoutFailureState extends CheckoutState {}
final class CheckoutDataIncompleteState extends CheckoutState {}
