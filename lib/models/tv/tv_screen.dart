

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wago/layout/cubit/cubit.dart';
import 'package:wago/layout/cubit/states.dart';
import 'package:wago/shared/components/components.dart';

class TvScreen extends StatefulWidget {


  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> with SingleTickerProviderStateMixin {
  TabController? controller;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller!.index = WagoCubit.get(context).selectedIndexTvScreen;
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
            length: 3,
            initialIndex: cubit.selectedIndexTvScreen,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  controller: controller,
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Top Rated',),
                    Tab(text: 'Popular',),
                    Tab(text: 'On Air',),
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
                    buildList(context, cubit.topRatedTv),
                    buildList(context, cubit.popularTv),
                    buildList(context, cubit.onTheAirTv),
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
