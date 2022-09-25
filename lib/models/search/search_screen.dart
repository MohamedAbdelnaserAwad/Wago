
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wago/layout/cubit/cubit.dart';
import 'package:wago/layout/cubit/states.dart';
import 'package:wago/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WagoCubit,WagoStates>(
      listener: (context,state){} ,
      builder: (context,state){
        var cubit = WagoCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 16.0,
                    ),
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (text){
                        cubit.getSearchResult(text);
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: IconButton(
                          onPressed: () {
                            cubit.getSearchResult(searchController.text);
                          },
                          icon: Icon(Icons.search),

                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is WagoSearchLoadingState) LinearProgressIndicator(),
                  if(state is WagoSearchSuccessState)
                  buildList(context,cubit.searchResult,isSearch: true),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
