// dropDownButton

class Category{
  static String musicId = 'music';
  static String movieId = 'movie';
  static String sportId = 'sports';

 String id;
 late String image;
 late String title;
  Category(this.id,this.image,this.title);

  Category.fromId(this.id){
    // if(id==musicId){
    //   image = 'assets/images/music.png';
    //   title ='music';
    // }
    image = 'assets/images/$id.png';
    title = id;
  }
  static List<Category>grtCategory(){
    return [
      Category.fromId(musicId),
      Category.fromId(movieId),
      Category.fromId(sportId)
    ];
  }
}