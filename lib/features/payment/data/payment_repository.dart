import 'package:f_localbrand/features/payment/data/payment_api_client.dart';
import 'package:f_localbrand/features/payment/dto/vnpay_response.dart';

class PaymentRepository {
  final PaymentApiClient paymentApiClient;
  PaymentRepository({required this.paymentApiClient});

  Future<String> checkPayment(VnpayResponse vnpayResponse) async {
    try {
      return await paymentApiClient.checkPayment(vnpayResponse);
    } catch (e) {
      rethrow;
    }
  }
}
