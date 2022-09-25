import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wago/layout/cubit/cubit.dart';
import 'package:wago/layout/cubit/states.dart';
import 'package:wago/shared/components/components.dart';

class MovieScreen extends StatefulWidget {



  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> with SingleTickerProviderStateMixin {
  TabController? controller;



  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller!.index = WagoCubit.get(context).selectedIndexMoviesScreen;
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WagoCubit,WagoStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = WagoCubit.get(context);
        return Scaffold(
          body: DefaultTabController(
                length: 4,
                initialIndex: cubit.selectedIndexMoviesScreen,
                child: Scaffold(
                  appBar: AppBar(
                    bottom: TabBar(
                      controller: controller,
                      isScrollable: true,
                      tabs: [
                        Tab(text: 'Top Rated',),
                        Tab(text: 'Popular',),
                        Tab(text: 'Now Playing',),
                        Tab(text: 'Up Coming',),
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                    ),
                    child: TabBarView(
                        controller: controller,
                         children: [
                           buildList(context, cubit.topRatedMovies),
                           buildList(context, cubit.popularMovies),
                           buildList(context, cubit.nowPlayingMovies),
                           buildList(context, cubit.upComingMovies),

                         ],
                    ),
                  ),
                ),
              ),
        );

      },
    );
  }
}
