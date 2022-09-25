import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wago/layout/cubit/cubit.dart';
import 'package:wago/layout/cubit/states.dart';
import 'package:wago/layout/wago_layout.dart';
import 'package:wago/models/details/details_sceen.dart';
import 'package:wago/models/movie/movie_screen.dart';
import 'package:wago/models/trending/trending_screen.dart';
import 'package:wago/models/tv/tv_screen.dart';
import 'package:wago/shared/components/components.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WagoCubit,WagoStates>(
      listener: (context,stste){},
      builder: (context,state){
        var cubit = WagoCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: true,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    TextButton(
                      onPressed: () {
                        cubit.currentIndex = 3;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => WagoLayout() )
                        );
                      },
                      child: Text(
                        'Trending',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    CarouselSlider(
                      items:cubit.trending!.map(
                            (e) => InkWell(
                              onTap: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => DetailsScreen(
                                      banner: e['backdrop_path'] ,
                                      poster: e['poster_path'],
                                      rate:  e['popularity'].toStringAsFixed(1),
                                      title: e['title'] != null ?
                                      e['title'] : ' ' ,
                                      releaseDate: e['release_date']!=null?
                                      e['release_date']:' ',
                                      description: e['overview'] ,
                                    ) )
                                );
                              },
                              child: Image(
                          image: NetworkImage('https://image.tmdb.org/t/p/w500'+e['poster_path']),
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                            ),).toList(),
                      options: CarouselOptions(
                        height: 250,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    SizedBox(height: 15.0,),

                    SizedBox(
                      height: 10.0 ,
                    ),
                    TextButton(
                      onPressed: (){
                        cubit.currentIndex = 1;
                        cubit.changeSelectedIndexMovie(0);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => WagoLayout() )
                        );
                      },
                      child: Text(
                        'Top Rated Movies',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    buildListHome(context, cubit.topRatedMovies),

                    SizedBox(
                      height: 10.0 ,
                    ),
                    TextButton(
                        onPressed: (){
                          cubit.currentIndex = 2;
                          cubit.changeSelectedIndexTv(0);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => WagoLayout() )
                          );
                        },
                      child: Text(
                        'Top Rated on Tv',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    buildListHome(context, cubit.topRatedTv),

                    SizedBox(
                      height: 10.0 ,
                    ),
                    TextButton(
                      onPressed: (){
                        cubit.changeSelectedIndexMovie(1);
                        cubit.currentIndex = 1;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => WagoLayout() )
                        );
                      },
                      child: Text(
                        'Popular Movies',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    buildListHome(context, cubit.popularMovies),

                    SizedBox(
                      height: 10.0 ,
                    ),
                    TextButton(
                      onPressed: (){
                        cubit.currentIndex = 2;
                        cubit.changeSelectedIndexTv(1);

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => WagoLayout() )
                        );
                      },
                      child: Text(
                        'Popular on Tv',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    buildListHome(context, cubit.popularTv),

                    SizedBox(
                      height: 10.0 ,
                    ),
                    TextButton(
                      onPressed: (){
                        cubit.changeSelectedIndexMovie(2);
                        cubit.currentIndex = 1;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => WagoLayout() )
                        );
                      },
                      child: Text(
                        'Now Playing Movies',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    buildListHome(context, cubit.nowPlayingMovies),

                    SizedBox(
                      height: 10.0 ,
                    ),
                    TextButton(
                      onPressed: (){
                        cubit.currentIndex = 2;
                        cubit.changeSelectedIndexTv(2);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => WagoLayout() )
                        );
                      },
                      child: Text(
                        'On The Air show',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    buildListHome(context, cubit.onTheAirTv),

                    SizedBox(
                      height: 10.0 ,
                    ),
                    TextButton(
                      onPressed: (){
                        cubit.changeSelectedIndexMovie(3);
                        cubit.currentIndex = 1;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => WagoLayout() )
                        );
                      },
                      child: Text(
                        'Up Coming Movies',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    buildListHome(context, cubit.upComingMovies),


                  ],
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),) ,
          ),
        );
      },
    );
  }
}
