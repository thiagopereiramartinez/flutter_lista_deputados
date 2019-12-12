import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:raphael/deputado.dart';
import 'package:http/http.dart' as http;
import 'package:raphael/tela2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "/detalhes": (context) => Tela2()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu super app",),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {},),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Teste 1"),
              ),
              PopupMenuItem(
                child: Text("Teste 2"),
              ),
              PopupMenuItem(
                child: Text("Teste 3"),
              ),
            ],
          )
        ],
      ),
      body: FutureBuilder(
        future: ler_deputados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Deu pau em tudo !"),);
            }

            if (snapshot.hasData) {

              List<Deputado> deputados = snapshot.data;

              return ListView.separated(
                itemCount: deputados.length,
                itemBuilder: (context, i) {

                  return ListTile(
                    title: Text(deputados[i].nome),
                    subtitle: Text(deputados[i].email),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(deputados[i].foto),
                    ),
                    onTap: () {
                      var retorno = Navigator.of(context).pushNamed("/detalhes");
                    },
                  );
                },
                separatorBuilder: (context, i) => Divider(height: 1,),
              );
            }

            return null;
          }

        },
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Thiago P. Martinez"),
              accountEmail: Text("thiago.pereira.ti@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://scontent.fcgb2-1.fna.fbcdn.net/v/t1.0-9/65305310_2265392160209120_8044799445662957568_n.jpg?_nc_cat=110&_nc_ohc=WXmvm3TwiygAQkLYwCe3zbVrXrgMrgZ08qG3nqdSJW5XA54TnXBWXJaqA&_nc_ht=scontent.fcgb2-1.fna&oh=a6058d6a70b107558b9628b2003d6cef&oe=5E794D13"),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current_index,
        onTap: (i) {
          setState(() {
            this._current_index = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Mensagens")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Perfil")
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }

  Future<List<Deputado>> ler_deputados() async {
    final request = await http.get("https://dadosabertos.camara.leg.br/api/v2/deputados?ordem=ASC&ordenarPor=nome", headers: {
      'accept': 'application/json'
    });

    final json = jsonDecode(request.body);
    final List<dynamic> dados = json["dados"];

    List<Deputado> deputados = List();

    dados.forEach((f) {
      deputados.add(Deputado.fromMap(f));
    });

    return deputados;
  }

}
