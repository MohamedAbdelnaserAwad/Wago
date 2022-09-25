import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wago/layout/cubit/cubit.dart';
import 'package:wago/models/splash/splash_screen.dart';
import 'package:wago/shared/network/local/cash_helper.dart';
import 'package:wago/shared/style/themes.dart';

import 'layout/cubit/states.dart';
import 'layout/wago_layout.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark') !=null
      ?CacheHelper.getData(key: 'isDark') : true;

  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;

  //constructor
  MyApp(this.isDark); // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WagoCubit()..loadMovies()..changeAppMode(
        fromShared: isDark
      ),
      child: BlocConsumer<WagoCubit,WagoStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: WagoCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:  SplashScreen(),
          );
        },
      ),
    );
  }
}

