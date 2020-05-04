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

  getUsers() async {
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
      body: buildListViewMahasiswa(context),
    );
  }

  ListView buildListViewMahasiswa(BuildContext context) {
    return ListView.builder(
//        reverse: true,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 5,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '${listMahasiswaTerbaru[index]['Nama']}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text('${listMahasiswaTerbaru[index]['NIM']}'),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: listMahasiswaTerbaru.length,
    );
  }
}
