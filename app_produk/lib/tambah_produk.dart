import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_produk/halaman_produk.dart';

class TambahProduk extends StatefulWidget {
  const TambahProduk({Key? key}) : super(key: key);

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _namaProdukController = TextEditingController();
  final TextEditingController _hargaProdukController = TextEditingController();

  Future<bool> _simpan() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.10.100/api_produk/create.php'),
        body: {
          'nama_produk': _namaProdukController.text,
          'harga_produk': _hargaProdukController.text,
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Produk'),
        backgroundColor: Colors.pinkAccent, // Ubah warna latar belakang appbar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _namaProdukController,
                  decoration: InputDecoration(
                    labelText: 'Nama Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama Produk tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _hargaProdukController,
                  decoration: InputDecoration(
                    labelText: 'Harga Produk',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Harga Produk tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _simpan().then((success) {
                        final snackBar = SnackBar(
                          content: Text(
                            success ? 'Data Berhasil Disimpan' : 'Gagal menyimpan data',
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        if (success) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HalamanProduk()),
                            (route) => false,
                          );
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent, // Ubah warna latar belakang tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
