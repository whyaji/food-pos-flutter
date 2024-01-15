class OrderItem {
  final int id;
  final int harga;
  final String catatan;

  OrderItem({
    required this.id,
    required this.harga,
    required this.catatan,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'harga': harga,
      'catatan': catatan,
    };
  }
}

class OrderRequest {
  final int? voucherId;
  final int nominalDiskon;
  final int nominalPesanan;
  final List<OrderItem> items;

  OrderRequest({
    this.voucherId,
    required this.nominalDiskon,
    required this.nominalPesanan,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'voucher_id': voucherId,
      'nominal_diskon': nominalDiskon,
      'nominal_pesanan': nominalPesanan,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderResponse {
  final int statusCode;
  final String message;

  OrderResponse({
    required this.statusCode,
    required this.message,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      statusCode: json['status_code'],
      message: json['message'],
    );
  }
}

class OrderCancelResponse {
  final int statusCode;
  final String message;

  OrderCancelResponse({
    required this.statusCode,
    required this.message,
  });

  factory OrderCancelResponse.fromJson(Map<String, dynamic> json) {
    return OrderCancelResponse(
      statusCode: json['status_code'],
      message: json['message'],
    );
  }
}
