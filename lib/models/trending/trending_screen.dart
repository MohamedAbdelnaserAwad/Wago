import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wago/layout/cubit/cubit.dart';
import 'package:wago/layout/cubit/states.dart';
import 'package:wago/shared/components/components.dart';

class TrendingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WagoCubit,WagoStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = WagoCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildList(context,cubit.trending),
          ),
        );
      },
    );
  }
}
