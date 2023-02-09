
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_home_layout/news_app_cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  // .......................    Bottom Navigation Bar Item   ....................
  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business),
      label: 'Business',
    ),

    const BottomNavigationBarItem(
        icon: Icon(Icons.sports),
      label: 'Sports',
    ),

    const BottomNavigationBarItem(
        icon: Icon(Icons.science),
      label: 'Science',
    ),
   ];

// ....................  Function to change index   ...........................
  int currentIndex = 0;
  void changeIndex(int index)
  {
    currentIndex = index;
    if(index == 1)
    {
      getSports();
    }
    if(index == 2)
    {
      getScience();
    }

    emit(NewsBottomNavState());
  }

//.....................     List Screen    ...................................
List<Widget> screens = [
  const BusinessScreen(),
  const SportsScreen(),
  const ScienceScreen(),
];

// ...................  Function To Get Data From Business   ...................
List<dynamic> business =[];
void getBusiness()
{
  emit( NewsGetBusinessLoadingState());
  DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'business' ,
        'apiKey':'1e2e3ea56c7743d39065949c6d8e18da',
      }
  ).then((value)
  {
    if (kDebugMode)
    {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }
  }).catchError((error)
  {
    if (kDebugMode)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    }
  });
}

// ....................   Function To Get Data From Sports  ....................
List<dynamic> sports =[];
void getSports()
{
  if(sports.isEmpty )
    {
      emit( NewsGetSportsLoadingState());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'sports' ,
            'apiKey':'1e2e3ea56c7743d39065949c6d8e18da',
          }
      ).then((value)
      {
        if (kDebugMode)
        {
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }
      }).catchError((error)
      {
        if (kDebugMode)
        {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        }
      });
    }
  else
    {
      emit(NewsGetSportsSuccessState());
    }
}

// .............  Function To Get Data From Science .............................
List<dynamic> science =[];
void getScience()
{
  if (science.isEmpty)
    {
      emit( NewsGetSportsLoadingState());
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'science' ,
            'apiKey':'1e2e3ea56c7743d39065949c6d8e18da',
          }
      ).then((value)
      {
        if (kDebugMode)
        {
          science = value.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccessState());
        }
      }).catchError((error)
      {
        if (kDebugMode)
        {
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        }
      });
    }
  else
    {
      emit(NewsGetScienceSuccessState());
    }

}

// ................. Function To Get Data From Science .......................
List<dynamic> search =[];
void getSearch(String value)
{
  emit( NewsGetSearchLoadingState());

  DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':value,
        'apiKey':'1e2e3ea56c7743d39065949c6d8e18da',
      }
  ).then((value)
  {
    if (kDebugMode)
    {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }
  }).catchError((error)
  {
    if (kDebugMode)
    {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    }
  });

}



}