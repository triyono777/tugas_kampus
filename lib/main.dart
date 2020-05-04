import 'dart:convert';
import 'package:data_mahasiswa/drawerTemplate.dart';
import 'package:data_mahasiswa/tambah_screen.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Data Mahasiswa UDB',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
//      home: MyHomePage(),
      routes: {
        MyHomePage.routeName: (ctx) => MyHomePage(),
        TambahScreen.routeName: (ctx) => TambahScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = '/';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String url = 'http://nurchim.tech/mobileC/ambilData.php';
//  String url = 'http://nurchim.tech/Mobile2020/readData.php';

  List listMahasiswa = [];
  List listMahasiswaTerbaru = [];

  Future<void> getUsers() async {
    http.Response response = await http.get(url);
    setState(() {
      listMahasiswa = jsonDecode(response.body);
      listMahasiswaTerbaru = listMahasiswa.reversed.toList();
    });
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Data Mahasiswa UDB'),
      ),
      drawer: TemplateDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, TambahScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
          onRefresh: getUsers, child: buildListViewMahasiswa(context)),
    );
  }

  ListView buildListViewMahasiswa(BuildContext context) {
    return ListView.builder(
//        reverse: true,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: ExpansionTile(
              title: Text(
                '${listMahasiswaTerbaru[index]['Nama']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${listMahasiswaTerbaru[index]['NIM']}'),
              leading: CircleAvatar(child: Icon(Icons.person)),
              children: <Widget>[
                buildItem(
                    label: 'Nama',
                    isi: '${listMahasiswaTerbaru[index]['Nama']}'),
                buildItem(
                    label: 'NIM', isi: '${listMahasiswaTerbaru[index]['NIM']}'),
                buildItem(
                    label: 'Kelas',
                    isi: '${listMahasiswaTerbaru[index]['Kelas']}'),
                buildItem(
                    label: 'Tgl daftar',
                    isi: '${listMahasiswaTerbaru[index]['Tgl']}'),
                buildItem(
                    label: 'Jam daftar',
                    isi: '${listMahasiswaTerbaru[index]['Jam']}'),
              ],
            ),
          ),
        );
      },
      itemCount: listMahasiswaTerbaru.length,
    );
  }

  Widget buildItem({String label, String isi}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: <Widget>[
          Expanded(child: Text('$label')),
          Expanded(
              child: Text(
            '$isi',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
