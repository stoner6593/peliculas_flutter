import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';
 
void main() => runApp(HomePage());
 
class HomePage extends StatelessWidget {

  final peliculaProvider= new PeliculasProviders();

  

  @override
  Widget build(BuildContext context) {

    peliculaProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text('Películas'),
        backgroundColor: (Colors.indigoAccent),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){
              showSearch(
                context: context, 
                delegate: DataSearch()
              );
            }
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            
            _swiperTarjetas(),
            _footer(context)

          ],
        )
      ),

    );
  }


  Widget _swiperTarjetas(){
  
    return FutureBuilder(
      future:  peliculaProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
         
         if( snapshot.hasData ){
          
          return CardSwiper( peliculas: snapshot.data);
        
         }else{

          return Container(
              height: 140.0,
              child: Center(
               child: CircularProgressIndicator()
              ),
           );

         }
         
      },
    );

  }

  Widget _footer(BuildContext context){

    return Container(
      width: double.infinity,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: 
              Text('Populares', 
                style: Theme.of(context).textTheme.subtitle2)
          ),
          SizedBox(height: 5.0,),
          StreamBuilder(
            stream: peliculaProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
           
              if( snapshot.hasData ){
                 return MovieHorizontal(
                   peliculas: snapshot.data,
                   siguientePagina: peliculaProvider.getPopulares
                  );
              }else{
                 return Container(
                    child: Center(
                    child: CircularProgressIndicator()
                    ),
                );
              }
             
            },
          ),
        ],
      ) ,
    );
  }
}