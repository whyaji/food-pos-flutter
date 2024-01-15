import 'package:flutter/material.dart';
import 'package:food_pos/components/menu_card.dart';
import 'package:food_pos/components/voucher_bottomsheet.dart';
import 'package:food_pos/models/menus.dart';
import 'package:food_pos/models/voucher.dart';
import 'package:food_pos/services/api_services.dart';
import 'package:intl/intl.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List<MenuItem> menus = [];
  List quant = [];
  int itemTotal = 0;
  int nominalPesanan = 0;
  int nominalDiskon = 0;
  int totalPembayaran = 0;
  String voucherCode = "";

  Future<void> fetchVoucher(String code) async {
    try {
      RestaurantApi restaurantApi = RestaurantApi();

      VoucherResponse voucherResponse =
          await restaurantApi.getVoucherData(code);

      if (code == voucherResponse.datas[0].kode) {
        setState(() {
          nominalDiskon = voucherResponse.datas[0].nominal;
        });
      } else {
        setState(() {
          nominalDiskon = 0;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        nominalDiskon = 0;
      });
    }
  }

  Future<void> fetchMenus() async {
    try {
      RestaurantApi restaurantApi = RestaurantApi();

      MenuResponse menuResponse = await restaurantApi.getMenuData();
      setState(() {
        menus = menuResponse.datas;
        quant = List.generate(menus.length, (index) => 0);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void setTotalPembayaran() {
    if (nominalDiskon < nominalPesanan) {
      totalPembayaran = nominalPesanan - nominalDiskon;
    } else if (nominalDiskon >= nominalPesanan) {
      totalPembayaran = 0;
    }
  }

  void updateVoucher(String code) {
    fetchVoucher(code);
  }

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > quant[index]) {
        nominalPesanan += menus[index].harga;
        itemTotal += 1;
      } else if (newQuantity < quant[index]) {
        nominalPesanan -= menus[index].harga;
        itemTotal -= 1;
      }
      quant[index] = newQuantity;
      setTotalPembayaran();
    });
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

    return formatter.format(amount);
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: menus.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: menus.length,
              itemBuilder: (BuildContext context, int index) {
                return MenuCard(
                    menu: menus[index],
                    quantity: quant[index],
                    onChange: (newQuantity) =>
                        {updateQuantity(index, newQuantity)});
              },
            ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Pesanan ($itemTotal Menu)"),
                          Text(formatCurrency(nominalPesanan))
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 1,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/icons/coupon.png"),
                              SizedBox(
                                width: 8,
                              ),
                              Text("Voucher")
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return VoucherInputBottomSheet(
                                      onChange: (voucher) =>
                                          {updateVoucher(voucher)});
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                    "Input Voucher\n-${formatCurrency(nominalDiskon)}"),
                                SizedBox(
                                  width: 8,
                                ),
                                Image.asset("assets/icons/right.png"),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/icons/cart.png"),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Pembayaran"),
                                      Text(formatCurrency(totalPembayaran)),
                                    ],
                                  )
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Pesan Sekarang"))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
