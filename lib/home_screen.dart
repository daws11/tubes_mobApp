import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    // Contoh data URL gambar, ganti dengan URL gambar sesungguhnya
    final List<String> imageUrls = [
      'https://placekitten.com/200/200',
      'https://placekitten.com/200/201',
      'https://placekitten.com/200/202',
      // Tambahkan lebih banyak URL gambar
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
            onPressed: () {
              authService.signOut();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom
          crossAxisSpacing: 10, // Spasi horizontal antar item
          mainAxisSpacing: 10, // Spasi vertikal antar item
          childAspectRatio: 1, // Rasio aspek item
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
