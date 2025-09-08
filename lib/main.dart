import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'input_mahasiswa_page.dart';
import 'package:url_launcher/url_launcher.dart'; // untuk latihan 3

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan Navigation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map<String, dynamic>? mahasiswaData;

  Future<void> _callMahasiswa() async {
    if (mahasiswaData != null && mahasiswaData!['kontak'] != null) {
      final phoneNumber = mahasiswaData!['kontak'];
      final Uri url = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tidak bisa membuka aplikasi telepon")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data mahasiswa belum ada")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()));
              },
              child: const Text("Menuju Profile Page"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InputMahasiswaPage()),
                );
                if (result != null) {
                  setState(() {
                    mahasiswaData = result;
                  });
                }
              },
              child: const Text("Input Data Mahasiswa"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _callMahasiswa,
              child: const Text("Call Mahasiswa"),
            ),
            const SizedBox(height: 32),
            const Text("Data Mahasiswa:"),
            mahasiswaData != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama: ${mahasiswaData!['nama']}"),
                      Text("Umur: ${mahasiswaData!['umur']}"),
                      Text("Alamat: ${mahasiswaData!['alamat']}"),
                      Text("Kontak: ${mahasiswaData!['kontak']}"),
                    ],
                  )
                : const Text("Belum ada data"),
          ],
        ),
      ),
    );
  }
}
