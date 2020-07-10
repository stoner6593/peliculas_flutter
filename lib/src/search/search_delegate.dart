import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas_model.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate{


  final peliculas = [
    'Rambo',
    'Matrix',
    'El artista',
    'El escandalo',
    'Sonic',
    'Parasitos',
    'Avengers',
    'Joker',
    'Frozen'
  ];


  final peliculaSugerida = [
    'Rambo',
    'Matrix'
  ];

  String peliculaSeleccionada='';

  final peliculaProvider= new PeliculasProviders();
  @override
  List<Widget> buildActions(BuildContext context) {
    // LAs acciones de nuestro AppBar
    return [
       IconButton(
         icon: Icon (Icons.close ), 
         onPressed: (){
           query='';
         }
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono que aparece a la izquiera del AppBar
   return IconButton(
     icon: AnimatedIcon(
       icon: AnimatedIcons.menu_arrow, 
       progress: transitionAnimation
     ), 
     onPressed: (){
      close(context, null);
     }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
     return Center(
       child: Container(
         height: 100.0,
         width: 100.0,
         color: Colors.amberAccent,
         child: Text(peliculaSeleccionada),
       ),
     );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Muestra las sugerencias que aparecen cuando la persona escribe
    
    if( query.isEmpty ){
      return Container();
    }

    return FutureBuilder(
      future: peliculaProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot <List<Pelicula>>  snapshot) {
        
        if(snapshot.hasData){

          final pelicula= snapshot.data;
          return ListView(
            children: pelicula.map((p) {

              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(p.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(p.title),
                subtitle: Text(p.originalTitle),
                onTap: (){
                  close(context, null);
                  p.uniqueId='';
                  Navigator.pushNamed(context, 'detalle', arguments: p);
                },
              );

            }).toList(),
            
          );

        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );


    /*final listaSugerida= (query.isEmpty) ?
                      peliculaSugerida : 
                      peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList(); 

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[index]),
          onTap: (){
           peliculaSeleccionada=listaSugerida[index];
           //showResults(context); redibuja el context para mostrar la pelicula seleccionada
          },
        ) ;
     },
    );*/
  }


}