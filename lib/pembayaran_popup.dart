import 'package:flutter/material.dart';

class Pembayaran_popup extends StatefulWidget {
  final String? name;
  final String? number;
  final String? rekening;
  final String? item;
  final String? total;

  const Pembayaran_popup(
      {Key? key,
      required this.name,
      required this.number,
      required this.rekening,
      required this.item,
      required this.total})
      : super(key: key);
  @override
  _Pembayaran_popupState createState() => _Pembayaran_popupState();
}

class _Pembayaran_popupState extends State<Pembayaran_popup> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.all(10),
      // backgroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Radius dari border
        side: BorderSide(
            color: Colors.orange, width: 1), // Warna dan ketebalan border
      ),

      // title: Text('Pembayaran Apply'),
      content: Container(
        height: 130,
        // color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // color: Colors.red,
              child: Text(
                'Nama     : ${widget.name}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
            Container(
              // color: Colors.red,

              child: Text(
                overflow: TextOverflow.ellipsis,
                'No HP    : ${widget.number}',
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
            Container(
              // color: Colors.red,
              child: Text(
                overflow: TextOverflow.ellipsis,
                'No Rek   : ${widget.rekening}',
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
            Container(
              // color: Colors.red,
              child: Text(
                overflow: TextOverflow.ellipsis,
                'Item       : ${widget.item}',
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
            Container(
              // color: Colors.red,
              child: Text(
                overflow: TextOverflow.ellipsis,
                'Total       : ${widget.total}',
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            )
          ],
        ),
      ),
      actions: [
        Container(
          // color: Colors.red,
          // height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  // minimumSize: Size(100, 2),
                  // maximumSize: Size(100, 30),
                  fixedSize: Size(100, 30),
                  backgroundColor: Colors.white,

                  elevation: 0,
                  // padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Cancel',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500)),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // minimumSize: Size(100, 2),
                  // maximumSize: Size(100, 30),
                  fixedSize: Size(100, 30),
                  backgroundColor: Colors.orange,
                  elevation: 0,
                  // padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Bayar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
