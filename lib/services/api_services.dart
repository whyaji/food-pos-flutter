import 'dart:convert';
import 'package:food_pos/models/menus.dart';
import 'package:food_pos/models/order.dart';
import 'package:food_pos/models/voucher.dart';
import 'package:http/http.dart' as http;

class RestaurantApi {
  static const String urlBase = 'https://tes-mobile.landa.id/api';
  final String baseUrl = 'https://tes-mobile.landa.id/api';

  Future<MenuResponse> getMenuData() async {
    const String endpoint = '/menus';
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'));

      if (response.statusCode == 200) {
        return MenuResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 204) {
        return MenuResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load menu data');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<VoucherResponse> getVoucherData(String voucherCode) async {
    const String endpoint = '/vouchers';
    try {
      final response =
          await http.get(Uri.parse('$baseUrl$endpoint?kode=$voucherCode'));

      if (response.statusCode == 200) {
        return VoucherResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 204) {
        return VoucherResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load voucher data');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<OrderResponse> sendOrder(OrderRequest orderRequest) async {
    const String endpoint = '/order';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(orderRequest.toJson()),
      );

      if (response.statusCode == 200) {
        return OrderResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create order');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<OrderCancelResponse> cancelOrder(int orderId) async {
    final String endpoint = '/order/cancel/$orderId';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return OrderCancelResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode == 204) {
        return OrderCancelResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to cancel order');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }
}
