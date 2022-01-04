// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:proyectofinal001/Theme.dart';

class Ingresar extends StatefulWidget {
  @override
  State<Ingresar> createState() => _IngresarState();
}

class _IngresarState extends State<Ingresar> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ingresar")),
      body: Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      color: whitee,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Image.asset("assets/images/256.png")
            ),
            SizedBox(height: 10),
            Text("¡Bienvenido a Wizard Note!",style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 7),
            TextFormField(
              onChanged: (value){
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Ingrese su Nombre',
              )
            ),
            SizedBox(height: 5),
            ElevatedButton(onPressed: (){
              var data = {'nameee':name};
              Navigator.pop(context, data);
            },
            child: Text("Guardar",style: TextStyle(color: whitee)),
            style: ElevatedButton.styleFrom(primary: blueSaphire)
            )],
        )
      )
    )
    );
  }
}