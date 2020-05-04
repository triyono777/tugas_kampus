import 'dart:convert';

import 'package:data_mahasiswa/main.dart';
import 'package:data_mahasiswa/tambah_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TemplateDrawer extends StatefulWidget {
  @override
  _TemplateDrawerState createState() => _TemplateDrawerState();
}

class _TemplateDrawerState extends State<TemplateDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 20, left: 20, right: 20),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          size: 70,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Triyono',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  softWrap: true,
                                ),
                                width: MediaQuery.of(context).size.width / 2.5,
                              ),
                              Container(
                                child: Text(
                                  'TI17C1',
                                  style: TextStyle(fontSize: 13),
                                ),
                                width: MediaQuery.of(context).size.width / 2.5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacementNamed(context, MyHomePage.routeName);
              },
              title: Text(
                'Dashboard',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushReplacementNamed(context, TambahScreen.routeName);
              },
              title: Text(
                'Tambah Mahasiswa',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
