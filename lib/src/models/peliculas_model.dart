// Generated by https://quicktype.io

class Peliculas {

  List<Pelicula> items = new List();

  Peliculas ();

  Peliculas.fromJsonList (List<dynamic> jsonList){

    if( jsonList == null  ) return;
    
    for ( var item in jsonList ){ 
      
      final pelicula= new Pelicula.fromJsonMap(item);
      
      items.add( pelicula );

    }
    
    
  }


}

class Pelicula {

  String uniqueId;

  int id;
  double popularity;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;

  Pelicula({
    this.popularity,
    this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
  });

  Pelicula.fromJsonMap( Map<String, dynamic> json ) {
    
    try {
    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];
    } on Exception catch (exception ) {

      print(exception);
      
    } catch (error) {
     print(error);
    }

    


  }

  getPosterImg (){
    if( posterPath==null ){
      return 'https://www.bobrick.com/wp-content/plugins/ultimate-product-catalogue/images/No-Photo-Available.png';
    }else{
        return 'http://image.tmdb.org/t/p/w500/$posterPath';
    }
  
  }

   getbackdropPathImg (){
    if( backdropPath==null ){
      return 'https://www.bobrick.com/wp-content/plugins/ultimate-product-catalogue/images/No-Photo-Available.png';
    }else{
        return 'http://image.tmdb.org/t/p/w500/$backdropPath';
    }
  
  }

}

//enum OriginalLanguage { EN, KO, ES, ZH }
