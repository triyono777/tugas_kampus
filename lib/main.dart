import 'dart:convert';
import 'package:data_mahasiswa/tambah_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
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
  String url = 'http://nurchim.tech/Mobile2020/readData.php';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, TambahScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Data Mahasiswa UDB'),
      ),
      body: ListView.builder(
//        reverse: true,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              child: ListTile(
                title: Text('${listMahasiswaTerbaru[index]['nama']}'),
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${listMahasiswaTerbaru[index]['NIM']}'),
                    Text('${listMahasiswaTerbaru[index]['email']}'),
                  ],
                ),
                trailing: Text('${listMahasiswaTerbaru[index]['kelas']}'),
                isThreeLine: true,
              ),
            ),
          );
        },
        itemCount: listMahasiswaTerbaru.length,
      ),
    );
  }
}
