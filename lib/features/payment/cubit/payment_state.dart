part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class PaymentInitSuccess extends PaymentState {
  final String paymentUrl;
  const PaymentInitSuccess(this.paymentUrl);
}

final class CheckPaymentInprogress extends PaymentState {}

final class CheckPaymentSuccess extends PaymentState {
  final String result;
  const CheckPaymentSuccess(this.result);
}

final class CheckPaymentFail extends PaymentState {
  final String message;
  const CheckPaymentFail(this.message);
}
