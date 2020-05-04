import 'package:data_mahasiswa/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahScreen extends StatefulWidget {
  static const routeName = '/tambah';
  @override
  _TambahScreenState createState() => _TambahScreenState();
}

class _TambahScreenState extends State<TambahScreen> {
  final TextEditingController conNama = TextEditingController();
  final TextEditingController conNim = TextEditingController();
  final TextEditingController conKelas = TextEditingController();
  final TextEditingController conEmail = TextEditingController();

  String urlTambah = 'http://nurchim.tech/mobileC/submitData.php';
//  String urlTambah = 'http://nurchim.tech/Mobile2020/saveData.php';
  addUser() async {
    final response = await http.post(urlTambah, body: {
      'NIM': conNim.text,
      'Nama': conNama.text,
      'Kelas': conKelas.text,
      'Email': conEmail.text,
    });
  }

  clearText() {
    conEmail.text = '';
    conNama.text = '';
    conNim.text = '';
    conKelas.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah data mahasiswa'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TemplateTextField(
              controller: conNim,
              label: 'Nim',
            ),
            TemplateTextField(
              controller: conNama,
              label: 'Nama',
            ),
            TemplateTextField(
              controller: conKelas,
              label: 'Kelas',
            ),
            TemplateTextField(
              controller: conEmail,
              label: 'Email',
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Colors.red,
                  onPressed: () {
                    clearText();
                    Navigator.pushReplacementNamed(
                        context, MyHomePage.routeName);
                  },
                  child: Text(
                    'Batal',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: Colors.green,
                  onPressed: () {
                    addUser();
                    clearText();

                    Navigator.pushReplacementNamed(
                        context, MyHomePage.routeName);
                  },
                  child: Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TemplateTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  const TemplateTextField({
    Key key,
    this.controller,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: '$label', hintText: 'Silahkan Masukkan $label'),
      ),
    );
  }
}
