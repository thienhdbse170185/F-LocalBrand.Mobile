import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';
import 'package:f_localbrand/features/order/data/order_repository.dart';
import 'package:f_localbrand/features/order/dto/order_details.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';
import 'package:f_localbrand/features/order/dto/order_tracking_dto.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({required this.orderRepository}) : super(OrderInitial());
  final OrderRepository orderRepository;

  Future<void> addOrder(List<ProductCartDto> orderList) async {
    emit(AddProductCartToOrderInprogress());

    // Convert the list of ProductCartDto to a list of SimplifiedProductCartDto
    List<SimplifiedProductCartDto> simplifiedItems = orderList.map((item) {
      return SimplifiedProductCartDto(
        id: item.id,
        quantity: item.quantity,
      );
    }).toList();

    // Create the OrderDto using the simplified items
    OrderDto order = OrderDto(items: simplifiedItems);

    try {
      String result = await orderRepository.addOrder(order);
      if (result.isNotEmpty) {
        print('Payment URL: $result');
        emit(AddProductCartToOrderSuccess(result));
      } else {
        emit(AddProductCartToOrderFail('Error! Cannot add order'));
      }
    } catch (e) {
      emit(AddProductCartToOrderFail(e.toString()));
    }
  }

  bool addToOrderList(List<ProductCartDto> cartList) {
    orderRepository.addToOrderList(cartList);
    return true;
  }

  List<ProductCartDto> getOrderList() {
    List<ProductCartDto> result = orderRepository.orderList;
    return result;
  }

  Future<void> fetchInprogressOrderTracking() async {
    emit(FetchInprogressOrderTrackingInprogress());
    try {
      List<OrderTrackingDTO> result =
          await orderRepository.getInprogressOrderTracking();
      emit(FetchInprogressOrderTrackingSuccess(result));
    } catch (e) {
      emit(FetchInprogressOrderTrackingFail(e.toString()));
    }
  }

  Future<void> fetchProductByOrderId(int orderId) async {
    emit(FetchOrderDetailsInprogress());
    try {
      List<OrderDetailsDTO> result =
          await orderRepository.getOrderDetails(orderId);
      emit(FetchOrderDetailsSuccess(result));
    } catch (e) {
      emit(FetchOrderDetailsFail(e.toString()));
    }
  }

  List<ProductCartDto> get orderList => orderRepository.orderList;
}
