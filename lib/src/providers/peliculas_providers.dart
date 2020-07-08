
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';

import 'package:peliculas/src/models/peliculas_model.dart';

class PeliculasProviders {


  String _apiKey   ='c05588a28d9105491b5f99dc0dc7297e';
  String _url      ='api.themoviedb.org';
  String _language ='es-ES';
  int    _popularesPage = 0;
  bool _cargando        = false;


  final List<Pelicula> _populares= new List();

  final _peliculaStreamController= StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get polularesSink => _peliculaStreamController.sink.add; 

  Stream<List<Pelicula>> get popularStream => _peliculaStreamController.stream;

  void disposeStream(){
    _peliculaStreamController?.close();
  }


  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    
    final respuesta=await http.get(url);
    final decodedData= json.decode(respuesta.body);
    
    final peliculas=new Peliculas.fromJsonList(decodedData['results']);
    
    return peliculas.items;

  }

  Future<List<Pelicula>> getEnCines() async{

    final url= Uri.https(_url, '3/movie/now_playing',
    {
      'api_key'   : _apiKey,
      'language'  : _language
    });

    return await _procesarRespuesta(url);
 
  }

  Future<List<Pelicula>> getPopulares() async{

    if( _cargando ) return [];

    _cargando=true;

    _popularesPage++;

    final url= Uri.https(_url, '3/movie/popular',
    {
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : _popularesPage.toString()
    });


    final resp= await _procesarRespuesta(url);

    _populares.addAll(resp);
    polularesSink(_populares);

    _cargando=false;

    return resp;


  }

  Future<List<Actor>> getActores(String peliId) async {

    final url= Uri.https(_url, '3/movie/$peliId/credits',
    {
      'api_key'   : _apiKey,
      'language'  : _language
    });

    final respuesta=await http.get(url);
    final decodedData= json.decode(respuesta.body);
    
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;

  }

}