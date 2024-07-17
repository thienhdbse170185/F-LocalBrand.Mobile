class OrderTrackingDTO {
  final int orderId;
  final double totalAmount;
  final String orderDate;
  final String orderStatus;
  final String currentStatus;
  final String changeTime;
  final int totalItem;

  OrderTrackingDTO(
      {required this.orderId,
      required this.totalAmount,
      required this.orderDate,
      required this.orderStatus,
      required this.currentStatus,
      required this.changeTime,
      required this.totalItem});

  factory OrderTrackingDTO.fromJson(Map<String, dynamic> json) {
    return OrderTrackingDTO(
        orderId: json['orderId'],
        totalAmount: json['totalAmount'],
        orderDate: json['orderDate'],
        orderStatus: json['orderStatus'],
        currentStatus: json['currentStatus'],
        changeTime: json['changeTime'],
        totalItem: json['totalItem']);
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'currentStatus': currentStatus,
      'changeTime': changeTime,
      'totalItem': totalItem
    };
  }

  @override
  String toString() {
    return 'OrderTrackingDTO{orderId: $orderId, totalAmount: $totalAmount, orderDate: $orderDate, orderStatus: $orderStatus, currentStatus: $currentStatus, changeTime: $changeTime, totalItem: $totalItem}';
  }
}
