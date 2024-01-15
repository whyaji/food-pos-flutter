import 'package:flutter/material.dart';

class VoucherInputBottomSheet extends StatefulWidget {
  final void Function(String) onChange;

  const VoucherInputBottomSheet({
    Key? key,
    required this.onChange,
  }) : super(key: key);
  @override
  _VoucherInputBottomSheetState createState() =>
      _VoucherInputBottomSheetState();
}

class _VoucherInputBottomSheetState extends State<VoucherInputBottomSheet> {
  TextEditingController voucherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Punya Kode Voucher?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: voucherController,
              decoration: InputDecoration(
                hintText: 'Masukan Kode Voucher Disini',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the voucher code here
                String voucherCode = voucherController.text;
                // Add your logic for voucher validation or processing here
                widget.onChange(voucherCode);

                // Close the bottom sheet
                Navigator.pop(context);
              },
              child: Text('Validasi Voucher'),
            ),
          ],
        ),
      ),
    );
  }
}
