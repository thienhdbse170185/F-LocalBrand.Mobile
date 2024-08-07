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

final class AddProductCartToOrderSuccess extends OrderState {
  final String paymentUrl;
  const AddProductCartToOrderSuccess(this.paymentUrl);
}

final class AddProductCartToOrderFail extends OrderState {
  final String message;
  const AddProductCartToOrderFail(this.message);

  @override
  List<Object> get props => [message];
}

final class GetOrderListInprogress extends OrderState {}

final class GetOrderListSuccess extends OrderState {
  final List<ProductCartDto> orderList;
  const GetOrderListSuccess(this.orderList);

  @override
  List<Object> get props => [orderList];
}

final class GetOrderListFail extends OrderState {
  final String message;
  const GetOrderListFail(this.message);

  @override
  List<Object> get props => [message];
}

final class FetchInprogressOrderTrackingInprogress extends OrderState {}

final class FetchInprogressOrderTrackingSuccess extends OrderState {
  final List<OrderTrackingDTO> orderTrackingList;
  const FetchInprogressOrderTrackingSuccess(this.orderTrackingList);

  @override
  List<Object> get props => [orderTrackingList];
}

final class FetchInprogressOrderTrackingFail extends OrderState {
  final String message;
  const FetchInprogressOrderTrackingFail(this.message);

  @override
  List<Object> get props => [message];
}

final class FetchOrderDetailsInprogress extends OrderState {}

final class FetchOrderDetailsSuccess extends OrderState {
  final List<OrderDetailsDTO> orderDetails;
  const FetchOrderDetailsSuccess(this.orderDetails);

  @override
  List<Object> get props => [orderDetails];
}

final class FetchOrderDetailsFail extends OrderState {
  final String message;
  const FetchOrderDetailsFail(this.message);

  @override
  List<Object> get props => [message];
}
