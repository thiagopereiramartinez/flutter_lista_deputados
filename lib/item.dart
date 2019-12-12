
import 'dart:ui';

import 'package:flutter/material.dart';

import 'deputado.dart';

class ItemDeputado extends StatefulWidget {

  final Deputado deputado;

  ItemDeputado({this.deputado});

  @override
  State<StatefulWidget> createState() => ItemDeputadoState();

}

class ItemDeputadoState extends State<ItemDeputado> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 16,
        height: 200,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(widget.deputado.foto, fit: BoxFit.cover,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.deputado.nome),
                Text(widget.deputado.email)
              ],
            )
          ],
        ),
      ),
    );
  }

}
