import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wago/models/search/search_screen.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class WagoLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <WagoCubit , WagoStates>(
      listener: (context, state) {} ,
      builder: (context, state) {
        var cubit = WagoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/images/wago_title.png',
            scale: 5.0,) ,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder:
                  (context) => SearchScreen()));
                },
              ),
              SizedBox(width: 5.0,),
              IconButton(
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: (){
                  WagoCubit.get(context).changeAppMode();
                },
              ),
              SizedBox(width: 5.0,),

            ],
          ),
          body: cubit.screens[cubit.currentIndex] ,

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
              print(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },


    );
  }
}
