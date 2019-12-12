
import 'package:flutter/material.dart';

import 'deputado.dart';

class Tela2 extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => Tela2State();

}

class Tela2State extends State<Tela2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dep. Bolsonaro"),
      ),
      body: Container(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network("https://www.camara.leg.br/internet/deputado/bandep/204554.jpg", fit: BoxFit.cover,),
        ),
      ),
    );
  }

}
