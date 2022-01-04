// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, non_constant_identifier_names, await_only_futures, unused_local_variable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ingresar.dart';

class MyDrawer extends StatefulWidget {

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  String name = "Usuario";
  String n = "U";

  log() async{
    var data = await Navigator.push(context, MaterialPageRoute(builder: (context) => Ingresar()));
    if (data != null){
        name= data['nameee'];
        saveName(data['nameee']);
        setState(()=>name);
    }
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text('e-mail@example'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: Text(
                n=name.substring(0,1),
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            title: Text('AMAZON'),
            leading: Icon(Icons.shopping_cart),
            onTap: () {
              launch("https://www.amazon.com.mx/");
            }
          ),
          Divider(),
          ListTile(
            title: Text('STEREN'),
            leading: Icon(Icons.cable),
            onTap: () {
              launch("https://www.steren.com.mx/");
            },
          ),
          Divider(),
          ListTile(
              title: Text('OFFICE MAX'),
              leading: Icon(Icons.shop),
              onTap: () {
                launch("https://www.officemax.com.mx/");
              }),
          Divider(),
          ListTile(
            title: Text('GOGLE DRIVE'),
            leading: Icon(Icons.add_to_drive_outlined),
            onTap: () {
              launch("https://drive.google.com/");
            },
          ),
          Divider(),
          ListTile(
            title: Text('GOGLE MAPS'),
            leading: Icon(Icons.map_outlined),
            onTap: () {
              launch("https://www.google.com.mx/maps");
            },
          ),
          Divider(),
          ListTile(
            title: Text('INGRESAR'),
            leading: Icon(Icons.open_in_browser_outlined),
            onTap: () {
              log();
              //Navigator.of(context).push(MaterialPageRoute(builder: (context) => Ingresar(),));
            }),
          Divider(),
          ListTile(
            title: Text('SALIR'),
            leading: Icon(Icons.window),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
  getName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = await prefs.getString('nam')??"";
    setState(()=>name);
    //n = name.substring(0,1);
  }

  Future saveName(String nam) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('nam', nam);

  }
}