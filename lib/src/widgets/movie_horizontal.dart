
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  

  MovieHorizontal ({ @required this.peliculas, @required this.siguientePagina });

  @override
  Widget build(BuildContext context) {

    final _pageController= PageController(
      initialPage: 1,
      viewportFraction: 0.3,
    );

    final _sizeScreen= MediaQuery.of(context).size;

   _pageController.addListener(() {
     
     if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {

        siguientePagina();
     }

   });

    return Container(
      height: _sizeScreen.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        itemCount:  peliculas.length,
        controller: _pageController,
        itemBuilder: (context, i){
         return _tarjeta(context, peliculas[i]); 
        },
        //children: _tarjetas(context),

      ),
    );
  }

  Widget _tarjeta (BuildContext context,Pelicula pelicula){

    pelicula.uniqueId="${pelicula.id}-poster";

    final tarjeta= Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 170.0,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

    return  GestureDetector(

      child: tarjeta,
      onTap: (){

        Navigator.pushNamed(context, 'detalle', arguments:  pelicula);

      },
      );
  }

  /* Se usaba cuando se llamaba en el widget ListView */
  List<Widget> _tarjetas(BuildContext context){

    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 170.0,
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();

  }
}