import 'package:vnpay_flutter/vnpay_flutter.dart';

class VNPayDTO {
  final String url;
  final String version;
  final String tmnCode;
  final String txnRef;
  final String orderInfo;
  final double amount;
  final String returnUrl;
  final String ipAddress;
  final String vnpayHashKey;
  final VNPayHashType vnpayHashType;
  final DateTime vnpayExpireDate;

  VNPayDTO({
    required this.url,
    required this.version,
    required this.tmnCode,
    required this.txnRef,
    required this.orderInfo,
    required this.amount,
    required this.returnUrl,
    required this.ipAddress,
    required this.vnpayHashKey,
    required this.vnpayHashType,
    required this.vnpayExpireDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'version': version,
      'tmnCode': tmnCode,
      'txnRef': txnRef,
      'orderInfo': orderInfo,
      'amount': amount,
      'returnUrl': returnUrl,
      'ipAddress': ipAddress,
      'vnpayHashKey': vnpayHashKey,
      'vnpayHashType': vnpayHashType.toString().split('.').last,
      'vnpayExpireDate': vnpayExpireDate?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'VNPayDTO(url: $url, version: $version, tmnCode: $tmnCode, txnRef: $txnRef, orderInfo: $orderInfo, amount: $amount, returnUrl: $returnUrl, ipAddress: $ipAddress, vnpayHashKey: $vnpayHashKey, vnpayHashType: $vnpayHashType, vnpayExpireDate: $vnpayExpireDate)';
  }
}
