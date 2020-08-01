class Post{
  int id ;
  bool isReacting = false ;
  bool reacted = false  ; 
  int reactId = -1 ;
  Post({
    this.id ,
    this.isReacting = false ,
    this.reacted = false,
    this.reactId = 0
  });
} 

class React {
  String name ;
  String imageUrl ;

  React({
    this.name ,
    this.imageUrl ,
  });
}


Post p1  = Post(
  isReacting: false  ,
  reacted: false ,
  reactId: -1
);

Post p2  = Post(
  isReacting: false  ,
  reacted: false ,
  reactId: -1
);

Post p3 = Post(
  isReacting: false  ,
  reacted: false ,
  reactId: -1
);

Post p4  = Post(
  isReacting: false  ,
  reacted: false ,
  reactId: -1
);

React sad = React(
  imageUrl: "assets/sad.png" ,
  name:  "Sad"
);
React love = React(
  imageUrl: "assets/love.png" ,
  name:  "love"
);
React angry = React(
  imageUrl: "assets/angry.png" ,
  name:  "angry"
);
React like = React(
  imageUrl: "assets/like.png" ,
  name:  "like"
);
React wow = React(
  imageUrl: "assets/wow.png" ,
  name:  "wow"
);
React haha = React(
  imageUrl: "assets/haha.png" ,
  name:  "haha"
);

List<React> reacts= [like , love , haha , wow , sad , angry] ;

List<Post> posts = [p1 , p2 , p3 , p4] ;

