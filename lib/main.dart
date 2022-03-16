import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ricerca_libro/libroScreen.dart';

import 'libro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I libri gioio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LibriScreen(),
    );
  }
}

class LibriScreen extends StatefulWidget {
  const LibriScreen({Key? key}) : super(key: key);

  @override
  _LibriScreenState createState() => _LibriScreenState();
}

class _LibriScreenState extends State<LibriScreen> {
  Icon icona = Icon(Icons.search);
  Widget widgetRicerca = Text('Libri');

  String risultato = 'Effettua una ricerca';
  List<Libro> libri = [];

  @override
  void initState() {
    cercaLibri('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widgetRicerca),
      body: libri.length == 0
          ? Center(
              child: Text(risultato),
            )
          : ListView.builder(
              itemCount: libri.length,
              itemBuilder: ((BuildContext context, int index) {
                return Card(
                  elevation: 2,
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => LibroScreen(libro: libri[index]));
                      Navigator.push(context, route);
                    },
                    leading: libri[index].immagineCopertina == ''
                        ? Text('Not immage')
                        : Image.network(libri[index].immagineCopertina),
                    title: Text(libri[index].titolo),
                    subtitle: Text(libri[index].autori),
                  ),
                );
              })),
    );
  }

  Future cercaLibri(String ricerca) async {
    final String dominio = 'www.googleapis.com';
    final String percorso = '/books/v1/volumes';
    Map<String, dynamic> parametri = {'q': ricerca};

    final Uri url = Uri.https(dominio, percorso, parametri);
    print(url);
    setState(() {
      risultato = "Caricamento in corso";
    });
    try {
      http.get(url).then((res) {
        final resJson = json.decode(res.body);
        final libriMap = resJson['items'];
        print(libriMap);
        if (libriMap != null)
          libri = libriMap.map<Libro>((value) => Libro.fromMap(value)).toList();

        setState(() {
          risultato = 'Effettua una ricerca';
          libri = libri;
        });
      });
    } on SocketException catch (e) {
      print('not connected2');
      print(e);
    }
  }
}
