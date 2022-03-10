import 'dart:async';
import 'dart:convert';

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

  String risultato = '';
  List<Libro> libri = [];

  @override
  void initState() {
    cercaLibri('flutter');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widgetRicerca),
      body: ListView.builder(
          itemCount: libri.length,
          itemBuilder: ((BuildContext context, int index) {
            return Card(
              elevation: 2,
              child: ListTile(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => LibroScreen(libri[index]));
                  Navigator.push(context, route);
                },
                leading: Image.network(libri[index].immagineCopertina),
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
    double tempoTrascorso = 0;
    var timer =
        Timer(Duration(seconds: 1), () => tempoTrascorso = tempoTrascorso + 1);
    final Uri url = Uri.https(dominio, percorso, parametri);

    http.get(url).then((res) {
      final resJson = json.decode(res.body);
      final libriMap = resJson['items'];

      libri = libriMap.map<Libro>((value) => Libro.fromMap(value)).toList();

      setState(() {
        libri = libri;
        print('tempo trascorso in secondi: ' + tempoTrascorso.toString());
        timer.cancel();
        risultato = res.body;
      });
    });
    setState(() {
      risultato = "Caricamento in corso";
    });
  }
}
