import "package:flutter/material.dart";

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  int? selectedDeliveryOptions;
  final List deliveryOptions = [
    {
      'type': "Priority",
      'Estimation': "(Estimasi 1-2 Hari)",
      "Price": "50.000"
    },
    {
      'type': "Standard",
      'Estimation': "(Estimasi 2-3 Hari)",
      "Price": "30.000"
    },
    {'type': "Saver", 'Estimation': "(Estimasi 4-5 Hari)", "Price": "20.000"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Purchase Now",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFF9900),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFFF9900), width: 1)),
              child: Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(10),
                child: Column(
                  children: [
                    ListTile(
                      leading:
                          Icon(IconData(0xe3ab, fontFamily: 'MaterialIcons')),
                      title: Text('Jl. M. H. Thamrin, Nomor 100A'),
                      subtitle: Text(
                        'Jl. M. H. Thamrin, Pusat Medan, Kota Medan, Sumatera Utara, Indonesia.',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 8),
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 1,
                                  offset: Offset(0, 5))
                            ]),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "UBAH ALAMAT ",
                                style: TextStyle(
                                    color: Color(0xFFFF9900), fontSize: 12),
                              ),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(0)),
                                  side: MaterialStateProperty.all(
                                      BorderSide(color: Color(0xFFFF9900))),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 255, 255, 255)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Adjust the radius here
                                  ))),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.local_shipping),
            title: Text("Delivery Options"),
          ),
          Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedDeliveryOptions;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            setState(() {
                              selectedDeliveryOptions = index;
                            });
                          },
                          child: ListTile(
                            selected: isSelected,
                            selectedColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            selectedTileColor: Colors.amber,
                            leading: Text(
                              '${deliveryOptions[index]['type']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            title: isSelected
                                ? Text(
                                    '${deliveryOptions[index]["Estimation"]}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  )
                                : Text(
                                    '${deliveryOptions[index]["Estimation"]}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xFFFF9900)),
                                  ),
                            trailing: Text(
                              '${deliveryOptions[index]['Price']}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
          )
        ],
      ),
    );
  }
}
