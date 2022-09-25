
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wago/models/details/details_sceen.dart';


Widget buildListHome (context, list) =>Container(
  width: double.infinity,
  height: 270,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: list.length,
    itemBuilder: (context,index){
      return InkWell(
        onTap: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailsScreen(
            banner: list[index]['backdrop_path'] ,
            poster: list[index]['poster_path'],
            rate:  list[index]['popularity'].toStringAsFixed(1),
            title: list[index]['title'] != null ?
            list[index]['title'] : ' ' ,
            releaseDate: list[index]['release_date']!=null?
            list[index]['release_date']:' ',
            description: list[index]['overview'] ,
          ) )
          );
        },
        child: Container(
          width: 150.0,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 210.0,
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500'+list[index]['poster_path'],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset('assets/images/no_image.png'),
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                '${list[index]['title'] != null
                    ? list[index]['title'] : ''}',
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 2,
              ),
            ],

          ),
        ),

      );
    },
  ),
);


Widget myDivider() => Container(
  width: double.infinity,
  height: 5.0,
  color: Colors.grey[300],
);



Widget buildList (context,list, {isSearch}) => ListView.separated(
  shrinkWrap: true,
  physics: isSearch !=null && isSearch ?
  NeverScrollableScrollPhysics() : null,
  scrollDirection: Axis.vertical,
  itemCount: list.length,
  itemBuilder: (context,index){
    return InkWell(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsScreen(
              banner: list[index]['backdrop_path'] ,
              poster: list[index]['poster_path'],
              rate:  list[index]['popularity'].toStringAsFixed(1),
              title: list[index]['title'] != null ?
              list[index]['title'] : ' ' ,
              releaseDate: list[index]['release_date']!=null?
              list[index]['release_date']:' ',
              description: list[index]['overview'] ,
            ) )
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500'+list[index]['poster_path'],
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Image.asset('assets/images/no_image.png'),
            width: 150.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${list[index]['title'] != null?
                    list[index]['title'] : ''}',
                    style: Theme.of(context).textTheme.subtitle1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${list[index]['release_date'] != null ?
                    list[index]['release_date'] : ''}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${list[index]['overview'] != null ?
                    list[index]['overview'] : ''}',
                    style: Theme.of(context).textTheme.headline2,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  },
  separatorBuilder: (context,index) => myDivider(),
);