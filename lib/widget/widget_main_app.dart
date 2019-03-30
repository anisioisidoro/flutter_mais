import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemList extends StatelessWidget {
  ItemList({this.list});
  final List list;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 10.0,
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            child: ExpansionTile(
              title: new Text(list[index]['name']),
              children: <Widget>[
               SvgPicture.network(list[index]['flag'], height: 100, width: 100,),
                new Text("População: ${list[index]['population']}"),
                new Text("Continente: ${list[index]['region']}"),
                new Text("Latitude  e longitiude: ${list[index]['latlng']}"),
                new Text("Extensão Territorial: ${list[index]['area']}"),
                new Text("domínio de nível superior: ${list[index]['topLevelDomain']}"),
              ],
            )
          );
        },
      ),
    );
  }
}