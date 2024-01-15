import 'package:flutter/material.dart';
import 'package:food_pos/models/menus.dart';

class MenuCard extends StatelessWidget {
  final MenuItem menu;
  final int quantity;
  final void Function(int) onChange;

  const MenuCard({
    Key? key,
    required this.menu,
    required this.quantity,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  color: Colors.grey[200],
                  height: 75,
                  width: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      menu.gambar,
                    ),
                  ),
                )),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.nama,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    "Rp ${menu.harga}",
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6.0),
                  SizedBox(
                    height: 18.0,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                      decoration: InputDecoration(
                        icon: Image.asset(
                          'assets/icons/edit.png',
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.only(bottom: 3),
                        border: InputBorder.none,
                        hintText: "Tambahkan Catatan",
                        hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (quantity != 0) {
                      onChange(quantity - 1);
                    }
                  },
                  child: Image.asset(
                    'assets/icons/decrement.png',
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(quantity.toString()),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    onChange(quantity + 1);
                  },
                  child: Image.asset(
                    'assets/icons/increment.png',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
