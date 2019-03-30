import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:saiba_mais/widget/widget_main_app.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading=true;
  TextEditingController _searchController = new TextEditingController();

  Future fetchCountry() async {
    final response = await http.get(
        Uri.encodeFull("https://restcountries.eu/rest/v2/name/${_searchController.text}"));
    if(response.statusCode==200){

      return json.decode(response.body);
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
           centerTitle: true,
          title: new  TextField(
            decoration: InputDecoration.collapsed(
                hintText: 'Procurar',
              hintStyle: TextStyle(color: Colors.white, fontSize: 20)
            ),
           onSubmitted:(value) {
             setState(() {
               isLoading ==true;
             });
             fetchCountry();
           },
            controller: _searchController,
            textInputAction: TextInputAction.go,
          ),
        ),


        body:Center(
            child: FutureBuilder(
              future: fetchCountry(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  return ItemList(list: snapshot.data,);
                }else{
                  return Center(
                    child:CircularProgressIndicator(),
                  );
                }

              },
            )



        )

    );
  }
}
