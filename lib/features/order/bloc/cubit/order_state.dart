part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderLoaded extends OrderState {
  final OrderDto order;
  const OrderLoaded(this.order);

  @override
  List<Object> get props => [order];
}

final class AddProductCartToOrderInprogress extends OrderState {}

final class AddProductCartToOrderSuccess extends OrderState {}

final class AddProductCartToOrderFail extends OrderState {
  final String message;
  const AddProductCartToOrderFail(this.message);

  @override
  List<Object> get props => [message];
}
