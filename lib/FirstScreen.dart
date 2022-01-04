// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, dead_code, unused_label, import_of_legacy_library_into_null_safe, avoid_print, prefer_final_fields, override_on_non_overriding_member, unused_field, annotate_overrides, must_be_immutable, non_constant_identifier_names, unused_element, prefer_equal_for_default_values, deprecated_member_use, prefer_const_constructors_in_immutables, unused_local_variable, await_only_futures, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, unused_import, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:proyectofinal001/CreateNote.dart';
import 'package:proyectofinal001/Theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Drawer.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  int indexa = 0;
  changevalue() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(()=>indexa++);
    prefs.setInt('value',indexa);
  }

  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime nowday = DateTime.now();

  String texto = '';
  String name = 'Usuario';

  List<Nota> notas = [
    //Nota("Nota guardada","contenido guardado",Color(0xffAED581)),
  ];

  List<String> nums=[];

  void addNote() async {
    var data = await Navigator.push(context, MaterialPageRoute(builder: (context) => Import()));
    if (data != null){
      String a = "$focusedDay";
      String b = a.substring(0, 10);
      a = a.substring(17);
      if(a != '00.000Z'){
        texto = "Sin fecha establecida";
        print(focusedDay);
        print(nowday);
        print(a);
        }
      else{texto = b;}
      Nota nota = Nota(data['title'], data['cont'], data['them'],texto);
      setState(()=> notas.add(nota));
      setState(()=> nums.add('$indexa'));
      guardar_datos(data['title'], data['cont'], data['them'], indexa, texto);
      guardar_lista(nums);
      changevalue();
      focusedDay = DateTime.now();
      selectedDay = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agenda de "+name)),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote();
          setState(()=>name);
        },
        child: Icon(Icons.add, color: whitee),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:<Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: selectedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekVisible: true,
              onDaySelected: (DateTime selectDay, DateTime focusDay){
                setState((){
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                  nowday = DateTime.now();
                });/*
                print(focusDay);
                print(selectDay);
                print(nowday);*/
              },
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format){
                setState((){
                  format = _format;
                });
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: blueCharcoal,
                  shape: BoxShape.circle
                ),
                todayDecoration: BoxDecoration(
                  color: blueSaphire,
                  shape: BoxShape.circle
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              selectedDayPredicate: (DateTime date){
                return isSameDay(selectedDay, date);
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextStyle: TextStyle(fontSize: 17.5)
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: notas.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                return Dismissible(
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 37),
                    color: Colors.red[800],
                    child: Icon(Icons.delete_sweep_sharp, size: 40.0, color: whitee)
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 37),
                    color: Colors.red[800],
                    child: Icon(Icons.delete_sweep_sharp, size:40.0, color: whitee)
                    ),
                  key: ObjectKey(nums[index]),
                  child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                    color: notas[index].color,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color:Colors.black38,
                        offset: Offset(6, 6),
                        blurRadius: 3
                      )
                    ]
                  ),
                  child: Padding(padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Stack(
                      children: <Widget>[
                      Text(notas[index].titulo, style:/*Theme.of(context).textTheme.headline5*/
                        TextStyle(fontSize: 20,
                        foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 5
                        ..color = Colors.black
                        )
                      ),
                      Text(notas[index].titulo, style:
                        TextStyle(
                          fontSize: 20,
                          color: notas[index].color
                        )
                      ),
                      ],),
                      SizedBox(height: 15),
                      Text(notas[index].descripcion, style: Theme.of(context).textTheme.subtitle2),
                      SizedBox(height: 15),
                      Text(notas[index].date),
                      //ElevatedButton(onPressed: ()=> print(index), child: Text('$index'))
                    ],
                  ))
                  ),
                onDismissed: (direction){
                  setState(() {
                    notas.removeAt(index);
                    nums.removeAt(index);
                    guardar_lista(nums);
                  });
                },
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider()
            )
      ]))
    );
  }

  mostrar_datos() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    indexa = prefs.getInt('value') ?? 0;

    name = await prefs.getString('nam')??"";
    setState(()=>name);

    //int inde = await prefs.getInt('index')??0;
    nums = await prefs.getStringList('list')??[];
    for(String i in nums){
      String tit = await prefs.getString('titulo'+i)??"";
      String not = await prefs.getString('contenido'+i)??"";
      String colstr = await prefs.getString('testcolor'+i)??"";
      int val = await prefs.getInt('intcolor'+i)??0;
      String dat = await prefs.getString('date'+i)??"";
      //int borrar = await prefs.getInt('value'+i)??0;

      Color otherColor = Color(val);

      Nota nota = Nota(tit, not, otherColor, dat);
      setState(()=> notas.add(nota)
      );
    }
  }

  Future guardar_datos(String titulo, String contenido, Color color, int inde, String date) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Color colors = color;
    String colorString = colors.toString();
    String valueString = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);

    await prefs.setString('titulo'+'$inde', titulo);
    await prefs.setString('contenido'+'$inde', contenido);
    await prefs.setString('testcolor'+'$inde', valueString);
    await prefs.setInt('intcolor'+'$inde',value);
    await prefs.setString('date'+'$inde',date);
    //indexa++;
  }

  /*guardar_index(int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('index',index);
  }*/

  guardar_lista(List<String> list) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('list', list);
  }

}

class Nota{
  String titulo = "";
  String descripcion = "";
  Color color = Color(0xffF90A0A);
  String date;
  //int llave = 0;

  Nota(this.titulo, this.descripcion, this.color, this.date);
}


