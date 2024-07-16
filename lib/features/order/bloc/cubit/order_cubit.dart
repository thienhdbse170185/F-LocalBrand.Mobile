import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';
import 'package:f_localbrand/features/order/data/order_repository.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';
import 'package:f_localbrand/features/payment/cubit/payment_cubit.dart';

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

  List<ProductCartDto> get orderList => orderRepository.orderList;
}
