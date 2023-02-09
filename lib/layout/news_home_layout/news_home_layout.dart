
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search.dart';
import 'package:news_app/shared/component/components.dart';
import 'package:news_app/shared/mode_cubit/cubit.dart';
import 'news_app_cubit/cubit.dart';
import 'news_app_cubit/states.dart';

class NewsAppHome extends StatelessWidget {
  const NewsAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit, NewsStates>(

     listener: (context , state) {},

     builder: (context , state) {

       NewsCubit cubit = NewsCubit.get(context);

       return Scaffold(

         //  .........................  App Bar ................................
         appBar:  AppBar(
           title:  const Text('News App'),
           actions: [
             IconButton(
               icon:  const Icon(Icons.search),
                 onPressed: ()
                 {
                   navigateTo(context,  const SearchScreen());
                 },
             ),

             IconButton(
               icon:  const Icon(Icons.brightness_4_outlined),
               onPressed: ()
               {
                 ModeCubit.get(context).changeAppMode();
               },
             ),

           ],
         ),

         // .................  Bottom Navigation Bar...........................
         bottomNavigationBar: BottomNavigationBar(
           items: cubit.bottomItem,
           currentIndex: cubit.currentIndex,
           onTap: (index)
           {
             cubit.changeIndex(index);
           },
         ),

         // .........................   Body ...................................
         body: cubit.screens[cubit.currentIndex],


       );
     },
    );
  }
}
