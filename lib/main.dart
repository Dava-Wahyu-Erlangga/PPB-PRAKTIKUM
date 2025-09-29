import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Model data Mahasiswa
class Mahasiswa {
  final String nama;
  final String email;
  final String hp;
  final String jenisKelamin;

  Mahasiswa({
    required this.nama,
    required this.email,
    required this.hp,
    required this.jenisKelamin,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Mahasiswa',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ListMahasiswa(),
    );
  }
}

// Halaman daftar mahasiswa
class ListMahasiswa extends StatefulWidget {
  const ListMahasiswa({super.key});

  @override
  State<ListMahasiswa> createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  final List<Mahasiswa> _listMahasiswa = [];

  void _tambahMahasiswa(Mahasiswa mhs) {
    setState(() {
      _listMahasiswa.add(mhs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Mahasiswa")),
      body: ListView.builder(
        itemCount: _listMahasiswa.length,
        itemBuilder: (context, index) {
          final mhs = _listMahasiswa[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(mhs.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${mhs.email}"),
                  Text("Nomor HP: ${mhs.hp}"),
                  Text("Jenis Kelamin: ${mhs.jenisKelamin}"),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final hasil = await Navigator.push<Mahasiswa>(
            context,
            MaterialPageRoute(
              builder: (context) => const FormMahasiswa(),
            ),
          );
          if (hasil != null) {
            _tambahMahasiswa(hasil);
          }
        },
        child: const Icon(Icons.add),
        tooltip: "Tambah Mahasiswa",
      ),
    );
  }
}

// Form input mahasiswa
class FormMahasiswa extends StatefulWidget {
  const FormMahasiswa({super.key});

  @override
  State<FormMahasiswa> createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  String? _jenisKelamin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Input Data Mahasiswa")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Lengkap",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  } else if (!value.endsWith("@unsika.ac.id")) {
                    return "Email harus menggunakan domain @unsika.ac.id";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hpController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Nomor HP",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nomor HP tidak boleh kosong";
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Nomor HP hanya boleh angka";
                  } else if (value.length < 10) {
                    return "Nomor HP minimal 10 digit";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _jenisKelamin,
                decoration: const InputDecoration(
                  labelText: "Jenis Kelamin",
                  prefixIcon: Icon(Icons.wc),
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Laki-laki",
                    child: Text("Laki-laki"),
                  ),
                  DropdownMenuItem(
                    value: "Perempuan",
                    child: Text("Perempuan"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Pilih jenis kelamin";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final mhs = Mahasiswa(
                      nama: _namaController.text,
                      email: _emailController.text,
                      hp: _hpController.text,
                      jenisKelamin: _jenisKelamin ?? "",
                    );
                    Navigator.pop(context, mhs);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
