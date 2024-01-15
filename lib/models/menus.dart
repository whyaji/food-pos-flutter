class MenuItem {
  final int id;
  final String nama;
  final int harga;
  final String tipe;
  final String gambar;

  MenuItem({
    required this.id,
    required this.nama,
    required this.harga,
    required this.tipe,
    required this.gambar,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      tipe: json['tipe'],
      gambar: json['gambar'],
    );
  }
}

class MenuResponse {
  final int statusCode;
  final List<MenuItem> datas;
  final String? message;

  MenuResponse({
    required this.statusCode,
    required this.datas,
    this.message,
  });

  factory MenuResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> datasJson = json['datas'] ?? [];
    List<MenuItem> datas =
        datasJson.map((data) => MenuItem.fromJson(data)).toList();

    return MenuResponse(
      statusCode: json['status_code'],
      datas: datas,
      message: json['message'],
    );
  }
}
