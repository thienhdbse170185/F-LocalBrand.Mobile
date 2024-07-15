import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';
import 'package:f_localbrand/features/order/data/order_repository.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({required this.orderRepository}) : super(OrderInitial());
  final OrderRepository orderRepository;

  Future<void> addOrder(List<ProductCartDto> items) async {
    emit(AddProductCartToOrderInprogress());

    // Convert the list of ProductCartDto to a list of SimplifiedProductCartDto
    List<SimplifiedProductCartDto> simplifiedItems = items.map((item) {
      return SimplifiedProductCartDto(
        id: item.id,
        quantity: item.quantity,
      );
    }).toList();

    // Create the OrderDto using the simplified items
    OrderDto order = OrderDto(items: simplifiedItems);

    try {
      bool result = await orderRepository.addOrder(order);
      if (result) {
        emit(AddProductCartToOrderSuccess());
      } else {
        emit(AddProductCartToOrderFail('Error! Cannot add order'));
      }
    } catch (e) {
      emit(AddProductCartToOrderFail(e.toString()));
    }
  }
}
