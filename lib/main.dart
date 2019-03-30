import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:saiba_mais/page/search_page.dart';
import 'package:saiba_mais/widget/widget_main_app.dart';
import 'dart:convert';

void main()=> runApp(
  new MaterialApp(
    theme: ThemeData.dark(),
    home: ManApp(),
  )
);

class ManApp extends StatefulWidget {
  @override
  _ManAppState createState() => _ManAppState();
}

class _ManAppState extends State<ManApp> {

  Future _fetchCountry() async {
    final response = await http.get(
        Uri.encodeFull("https://restcountries.eu/rest/v2/all"));
      if(response.statusCode==200){
        return json.decode(response.body);
      }else{
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: new Text("Erro"),
              content: new Text(response.body),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: ()=>Navigator.pop(context),
                )
              ],
            ),
            barrierDismissible: true
        );
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Saiba Mais"),
        centerTitle: true,
      ),
        floatingActionButton: FloatingActionButton(
            child: new Icon(Icons.search),
            onPressed: ()=> Navigator.push(context,
                MaterialPageRoute(
                    builder:(BuildContext context) => SearchPage())
            )),
      body:Center(
        child: FutureBuilder(
          future: _fetchCountry(),
          builder: (BuildContext context, snapshot){
            if(snapshot.hasData){
              return ItemList(list: snapshot.data,);
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )



      )

    );
  }
}

