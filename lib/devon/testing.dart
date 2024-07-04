import 'dart:convert';

void sorttermurah(List<Map<String, dynamic>> data) {
  try {
    data.sort((a, b) {
      try {
        // Extracting and parsing the price from the nested item map
        int priceA = int.parse(a['item']['harga']);
        int priceB = int.parse(b['item']['harga']);
        return priceA.compareTo(priceB);
      } catch (e) {
        print('Error parsing price for comparison: $e');
        // If an error occurs, return 0 to indicate no change in order
        return 0;
      }
    });
  } catch (e) {
    print('Error sorting data: $e');
  }
}

void main() {
  // JSON string data
  String jsonData = '''
  [
    {
      "_id": "6684f488507de4c19f090a73",
      "user_id": "66842a6862b6acaaa073e49c",
      "item_id": "6684f454507de4c19f090a6a",
      "delivery_options": "Priority",
      "alamat": "Jl. M. H. Thamrin, Nomor 100A",
      "metode_pembayaran": "bca",
      "penilaian": null,
      "item": {
        "_id": "6684f454507de4c19f090a6a",
        "user": "66842a6862b6acaaa073e49c",
        "nama_produk": "Kaos Polo Shirt Custom Design Logo Sendiri Bordir/Sablon Satuan",
        "jumlah": 1,
        "harga": "75636",
        "rating": 0,
        "penjualan": 0,
        "lokasi": "N/A",
        "nama_toko": "N/A",
        "image_url": "https://images.tokopedia.net/img/cache/200-square/VqbcmM/2024/6/12/eafd0114-b589-4464-8585-8fe56fd9b74d.jpg.webp?ect=3g",
        "marketplace": "tokopedia",
        "status": "beli"
      }
    },
    {
      "_id": "6684f5b2ad69702c8ba70bc9",
      "user_id": "66842a6862b6acaaa073e49c",
      "item_id": "6684f581ad69702c8ba70bc0",
      "delivery_options": "Priority",
      "alamat": "Jl. M. H. Thamrin, Nomor 100A",
      "metode_pembayaran": "ovo",
      "penilaian": null,
      "item": {
        "_id": "6684f581ad69702c8ba70bc0",
        "user": "66842a6862b6acaaa073e49c",
        "nama_produk": "Mouse Pad Aukey KM-P2 - 500878",
        "jumlah": 1,
        "harga": "30000",
        "rating": 0,
        "penjualan": 0,
        "lokasi": "N/A",
        "nama_toko": "N/A",
        "image_url": "https://images.tokopedia.net/img/cache/200-square/VqbcmM/2024/2/22/f6bb49d6-885a-49b9-b512-ad5679ab017b.png.webp?ect=3g",
        "marketplace": "tokopedia",
        "status": "beli"
      }
    },
    {
      "_id": "6684f5b2ad69702c8ba70bcb",
      "user_id": "66842a6862b6acaaa073e49c",
      "item_id": "6684f582ad69702c8ba70bc2",
      "delivery_options": "Priority",
      "alamat": "Jl. M. H. Thamrin, Nomor 100A",
      "metode_pembayaran": "ovo",
      "penilaian": null,
      "item": {
        "_id": "6684f582ad69702c8ba70bc2",
        "user": "66842a6862b6acaaa073e49c",
        "nama_produk": "Robot M205 Wireless Mouse Optical 2.4G & Tombol Sakelar DPI",
        "jumlah": 1,
        "harga": "45000",
        "rating": 0,
        "penjualan": 0,
        "lokasi": "N/A",
        "nama_toko": "N/A",
        "image_url": "https://images.tokopedia.net/img/cache/200-square/VqbcmM/2024/5/15/18c586e6-503f-49e2-b94a-c16557ae259a.jpg.webp?ect=3g",
        "marketplace": "tokopedia",
        "status": "beli"
      }
    },
    {
      "_id": "6684f5b2ad69702c8ba70bcd",
      "user_id": "66842a6862b6acaaa073e49c",
      "item_id": "6684f58bad69702c8ba70bc5",
      "delivery_options": "Priority",
      "alamat": "Jl. M. H. Thamrin, Nomor 100A",
      "metode_pembayaran": "ovo",
      "penilaian": null,
      "item": {
        "_id": "6684f58bad69702c8ba70bc5",
        "user": "66842a6862b6acaaa073e49c",
        "nama_produk": "Gaming Mouse Pad Desk Mat Polos Bagus Murah",
        "jumlah": 1,
        "harga": "17900",
        "rating": 4.9,
        "penjualan": "Terjual 25",
        "lokasi": "Jakarta Barat",
        "nama_toko": "Buzper",
        "image_url": "https://s0.bukalapak.com/ast/bazaar-dweb/base/images/ico_loading.png",
        "marketplace": "bukalapak",
        "status": "beli"
      }
    }
  ]''';

  // Parse JSON string to a list of maps
  List<Map<String, dynamic>> data =
      List<Map<String, dynamic>>.from(json.decode(jsonData));

  // Sort the data by price
  sorttermurah(data);

  // Print sorted data
  data.forEach((element) {
    print(
        'Item: ${element['item']['nama_produk']}, Price: ${element['item']['harga']}');
  });
}
