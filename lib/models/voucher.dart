class Voucher {
  final int id;
  final String kode;
  final String gambar;
  final int nominal;
  final String status;
  final String createdAt;
  final String updatedAt;

  Voucher({
    required this.id,
    required this.kode,
    required this.gambar,
    required this.nominal,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'],
      kode: json['kode'],
      gambar: json['gambar'],
      nominal: json['nominal'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class VoucherResponse {
  final int statusCode;
  final List<Voucher> datas;
  final String? message;

  VoucherResponse({
    required this.statusCode,
    required this.datas,
    this.message,
  });

  factory VoucherResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> datasJson = json['datas'] ?? [];
    List<Voucher> datas =
        datasJson.map((data) => Voucher.fromJson(data)).toList();

    return VoucherResponse(
      statusCode: json['status_code'],
      datas: datas,
      message: json['message'],
    );
  }
}
