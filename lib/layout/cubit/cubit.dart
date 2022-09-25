import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:wago/layout/cubit/states.dart';
import 'package:wago/models/home/home.dart';
import 'package:wago/models/movie/movie_screen.dart';
import 'package:wago/models/search/search_screen.dart';
import 'package:wago/models/trending/trending_screen.dart';
import 'package:wago/models/tv/tv_screen.dart';
import 'package:wago/shared/network/local/cash_helper.dart';

class WagoCubit extends Cubit<WagoStates>{
  WagoCubit() : super(WagoInitialState());

  static WagoCubit get(context) => BlocProvider.of(context);


  final String apiKey = '3aa88d7b944fd9d051bf752d1fc1d78a';
  final readAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYWE4OGQ3Yjk0NGZkOWQwNTFiZjc1MmQxZmMxZDc4YSIsInN1YiI6IjVjOWRlNzlkYzNhMzY4NmYxMTAwOWEzYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.emYLbzlm_bxX9KMrNExZWm99S2CF45vCjcMU770x588';

  // list of trending
  List? trending = [];

  //all movies lists
  List? topRatedMovies = [];
  List? popularMovies = [];
  List? nowPlayingMovies = [];
  List? upComingMovies = [];

  //all tv lists
  List? latestTv = [];
  List? onTheAirTv = [];
  List? popularTv = [];
  List? topRatedTv = [];

  //all people list

  // List? detailsPeople = [];
  // List? moviesPeople = [];
  // List? tvPeople = [];
  // List? latestPeople = [];
  // List? popularPeople = [];


  loadMovies()async{
    TMDB tmdbWithcustomLogs = TMDB(ApiKeys(apiKey,readAccessToken),
    logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ));
   //Map of trending
    Map trendingResult = await tmdbWithcustomLogs.v3.trending.getTrending();

    //all movie Maps
    Map topRatedMovieResult = await tmdbWithcustomLogs.v3.movies.getTopRated();
    Map popularMovieResult = await tmdbWithcustomLogs.v3.movies.getPopular();
    Map nowPlayingMovieResult = await tmdbWithcustomLogs.v3.movies.getNowPlaying();
    Map upComingMovieResult = await tmdbWithcustomLogs.v3.movies.getUpcoming();

    //all tv Maps
    Map latestTvResult = await tmdbWithcustomLogs.v3.tv.getLatest();
    Map onTheAirTvResult = await tmdbWithcustomLogs.v3.tv.getOnTheAir();
    Map popularTvResult = await tmdbWithcustomLogs.v3.tv.getPopular();
    Map topRatedTvResult = await tmdbWithcustomLogs.v3.tv.getTopRated();
   

   //fill trending list
    trending = trendingResult['results'];

    //fill movie lists
    topRatedMovies = topRatedMovieResult['results'];
    popularMovies = popularMovieResult['results'];
    nowPlayingMovies = nowPlayingMovieResult['results'];
    upComingMovies = upComingMovieResult['results'];

    //fill tv lists
    latestTv = latestTvResult['results'];
    onTheAirTv = onTheAirTvResult['results'];
    popularTv = popularTvResult['results'];
    topRatedTv = topRatedTvResult['results'];

    emit(WagoLoadDataSuccessState());
  }

  //changing mood method
  bool isDark = true;
  void changeAppMode({bool? fromShared})
  {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(WagoChangeModeState());
    } else
    {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(WagoChangeModeState());
      });
    }
  }

  //bottom navigation bar

  int currentIndex = 0 ;
  List<BottomNavigationBarItem> bottomItems =
  [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.movie_filter_outlined,
      ),
      label: 'Movies',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.tv_outlined,
      ),
      label: 'TV',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.wallet_membership_outlined,
      ),
      label: 'Trending',
    ),
  ];

  List<Widget> screens =
  [
    HomeScreen(),
    MovieScreen(),
    TvScreen(),
    TrendingScreen(),
    SearchScreen(),
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(WagoChangeNavBarState());
  }

  int selectedIndexMoviesScreen = 0;
   void changeSelectedIndexMovie(int index){
     selectedIndexMoviesScreen =index;
     emit(WagoChangeInitialTapMovieState());
   }

   int selectedIndexTvScreen = 0;
   void changeSelectedIndexTv(int index){
     selectedIndexTvScreen =index;
     emit(WagoChangeInitialTapTvState());
   }


   List? searchResult;
   void getSearchResult(String query)async{
     emit(WagoSearchLoadingState());
     TMDB tmdbWithcustomLogs = TMDB(ApiKeys(apiKey,readAccessToken),
         logConfig: ConfigLogger(
           showLogs: true,
           showErrorLogs: true,
         ));
     Map result = await tmdbWithcustomLogs.v3.trending.getTrending();
     searchResult = result['results'];
     print(searchResult);
     emit(WagoSearchSuccessState());
   }


}