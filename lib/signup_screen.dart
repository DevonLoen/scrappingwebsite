import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrappingwebsite/login_screen.dart';
import 'package:scrappingwebsite/user_provider.dart';

class Signup_screen extends StatefulWidget {
  const Signup_screen({super.key});

  @override
  State<Signup_screen> createState() => _Signup_screenState();
}

class _Signup_screenState extends State<Signup_screen> {
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final itemListProvider = Provider.of<ItemListProvider>(context);
    final itemList = itemListProvider.items;
    return Scaffold(
      body: Column(
        children: [
          Container(
            // color: Colors.blue,
            decoration: BoxDecoration(
              color: Color(0xFFFF9900),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(150),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFFB03A), // Warna bayangan
                  spreadRadius: 15, // Jangkauan bayangan
                  // blurRadius: 10, // Jarak blur bayangan
                  // offset: Offset(4, 4), // Offset bayangan (x, y)
                ),
              ],
            ),
            width: double.infinity,
            height: 180.0,
            child: Text(''),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 35, // Ukuran font
              // fontStyle: FontStyle.italic, // Gaya font (miring)
              fontWeight: FontWeight.bold, // Berat font (tebal)
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Name',
                prefixIcon: Icon(Icons.person), // Ikon di depan TextField
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Email',
                prefixIcon: Icon(Icons.mail), // Ikon di depan TextField
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _passwordController,
              obscureText: true, // Hide password input
              decoration: InputDecoration(
                // labelText: 'Password',
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock), // Ikon di depan TextField
                // suffixIcon: Icon(Icons.check),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Color(0xFFCACACA),
              backgroundColor: Colors.orange,
              elevation: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27.10)),
              minimumSize: Size(200, 45),
              shadowColor: Colors.black,
            ),
            onPressed: () {
              Item newItem = Item(
                  name: 'John Doe',
                  email: 'john@example.com',
                  password: '123456');
              itemListProvider.addItem(newItem);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login_screen()),
              );
            },
            child: Text('Sign Up'),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 30,
                  endIndent: 10, // Jarak antara Divider dan teks
                ),
              ),
              Text(
                ' Or signup with ',
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 10, // Jarak antara Divider dan teks
                  endIndent: 30, // Jarak antara Divider dan teks
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // Tindakan yang ingin dilakukan saat CircleAvatar diklik
                  print('CircleAvatar diklik!');
                },
                borderRadius: BorderRadius.circular(
                    5), // Membuat efek ink menyesuaikan bentuk CircleAvatar
                child: CircleAvatar(
                    radius: 18, backgroundColor: Colors.blue, child: Text('')),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  // Tindakan yang ingin dilakukan saat CircleAvatar diklik
                  print('CircleAvatar diklik!');
                },
                borderRadius: BorderRadius.circular(
                    5), // Membuat efek ink menyesuaikan bentuk CircleAvatar
                child: CircleAvatar(
                    radius: 18, backgroundColor: Colors.blue, child: Text('')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
