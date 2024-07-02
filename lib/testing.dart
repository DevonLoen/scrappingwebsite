void sortProductsByPriceDescending(List<dynamic> products) {
  products.sort((a, b) => double.parse(b['harga'].replaceAll('.', ''))
      .compareTo(double.parse(a['harga'].replaceAll('.', ''))));
}

void sortProductsByPriceAscending(List<dynamic> products) {
  products.sort((a, b) => double.parse(a['harga'].replaceAll('.', ''))
      .compareTo(double.parse(b['harga'].replaceAll('.', ''))));
}

void main() {
  List<dynamic> products = [
    {
      'img':
          'https://s1.bukalapak.com/img/65384570011/s-330-330/Acetech_RGB_Wireless_Charging_Gaming_Mouse_2.png.webp',
      'nama_produk':
          'Acetech RGB Wireless Charging Gaming Mouse 2.4Ghz For Komputer laptop PC Free Mouse Pad',
      'harga': '2.393.000',
      'rating': 4,
      'penjualan': 'Terjual 2',
      'lokasi': 'Tangerang',
      'nama_toko': 'Global Jaya Shop',
      'link_detail':
          'https://www.bukalapak.com/p/elektronik/elektronik-lainnya/1trvdim-jual-acetech-rgb-wireless-charging-gaming-mouse-2-4ghz-for-komputer-laptop-pc-free-mouse-pad?from=list-product&pos=0'
    },
    {
      'img':
          'https://s2.bukalapak.com/img/24182582992/s-330-330/data.jpeg.webp',
      'nama_produk':
          'Acome Mouse Fashion Color Wireless Silent Click Ergonomic AM300',
      'harga': '293.000',
      'rating': 5,
      'penjualan': 'Terjual 2',
      'lokasi': 'Tangerang Selatan',
      'nama_toko': 'Panda Store',
      'link_detail':
          'https://www.bukalapak.com/p/komputer/aksesoris-226/mouse/4hezt84-jual-acome-mouse-fashion-color-wireless-silent-click-ergonomic-am300?from=list-product&pos=1'
    },
    {
      'img': 'https://s0.bukalapak.com/img/09353390992/s-330-330/data.png.webp',
      'nama_produk':
          'Mouse Philips G314 PH-SPK9314 Macro Gaming Mouse Ambiglow RGB',
      'harga': '2.000',
      'rating': 5,
      'penjualan': 'Terjual 1',
      'lokasi': 'Tangerang Selatan',
      'nama_toko': 'Panda Store',
      'link_detail':
          'https://www.bukalapak.com/p/komputer/aksesoris-226/mouse/4he0tvp-jual-mouse-philips-g314-ph-spk9314-macro-gaming-mouse-ambiglow-rgb?from=list-product&pos=2'
    },
    {
      'img':
          'https://s3.bukalapak.com/img/82744433203/s-330-330/data.jpeg.webp',
      'nama_produk':
          'Mouse Wireless 2.4Ghz Optical 1200DPI Kursor Akurat for PC Laptop Mouse Gaming',
      'harga': '239.000',
      'rating': 5,
      'penjualan': 'Terjual 1',
      'lokasi': 'Tangerang',
      'nama_toko': 'Global Jaya Shop',
      'link_detail':
          'https://www.bukalapak.com/p/komputer/aksesoris-226/mouse/17q4990-jual-mouse-wireless-2-4ghz-optical-1200dpi-kursor-akurat-for-pc-laptop-mouse-gaming?from=list-product&pos=3'
    },
    {
      'img':
          'https://s4.bukalapak.com/img/47329938103/s-330-330/data.jpeg.webp',
      'nama_produk':
          'Mouse PC Gaming USB Komputer Laptop Led Rgb Foyu Lighting',
      'harga': '2.393.100',
      'rating': 0,
      'penjualan': 0,
      'lokasi': 'Tangerang Selatan',
      'nama_toko': 'Panda Store',
      'link_detail':
          'https://www.bukalapak.com/p/komputer/aksesoris-226/mouse/4hppmzs-jual-mouse-pc-gaming-usb-komputer-laptop-led-rgb-foyu-lighting?from=list-product&pos=4'
    },
    {
      'img': 'https://s2.bukalapak.com/img/73823199103/s-330-330/data.png.webp',
      'nama_produk': 'Apple Accessories Magic Mouse 3/2021 Silver MK2E3 Resmi',
      'harga': '3.293.000',
      'rating': 4.7,
      'penjualan': 'Terjual 33',
      'lokasi': 'Jakarta Pusat',
      'nama_toko': 'GorillaTech',
      'link_detail':
          'https://www.bukalapak.com/p/gorillatech/gadget-acc/adaptor-cables/4hoevxv-jual-apple-accessories-magic-mouse-3-2021-silver-mk2e3-resmi?from=list-product&pos=5'
    },
    {
      'img': 'https://s1.bukalapak.com/img/62723199103/s-330-330/data.png.webp',
      'nama_produk':
          'Apple Accessories Magic Mouse Black Multi Touch Surface MMMQ3 Resmi',
      'harga': '23.000',
      'rating': 4.7,
      'penjualan': 'Terjual 30',
      'lokasi': 'Jakarta Pusat',
      'nama_toko': 'GorillaTech',
      'link_detail':
          'https://www.bukalapak.com/p/gorillatech/gadget-acc/adaptor-cables/4hoevxy-jual-apple-accessories-magic-mouse-black-multi-touch-surface-mmmq3-resmi?from=list-product&pos=6'
    },
  ];

  sortProductsByPriceDescending(products);
  // sortProductsByPriceAscending(products);
  for (var product in products) {
    print(product['nama_produk'] + ' - Rp ' + product['harga'].toString());
  }
}
