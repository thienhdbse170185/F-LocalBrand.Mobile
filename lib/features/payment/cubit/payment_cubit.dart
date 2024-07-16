import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/payment/data/payment_repository.dart';
import 'package:f_localbrand/features/payment/dto/vnpay_dto.dart';
import 'package:f_localbrand/features/payment/dto/vnpay_response.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({required this.paymentRepository}) : super(PaymentInitial());
  final PaymentRepository paymentRepository;

  Future<void> initPayment(String paymentUrl) async {
    emit(PaymentInitSuccess(paymentUrl));
  }

  Future<void> checkPayment(Uri uri) async {
    emit(CheckPaymentInprogress());
    VnpayResponse vnPayResponse = VnpayResponse.fromUrl(uri);
    try {
      String result = await paymentRepository.checkPayment(vnPayResponse);
      if (result.isNotEmpty) {
        emit(CheckPaymentSuccess(result));
      } else {
        emit(CheckPaymentFail('Error! Cannot check payment'));
      }
    } catch (e) {
      emit(CheckPaymentFail(e.toString()));
    }
  }
}
