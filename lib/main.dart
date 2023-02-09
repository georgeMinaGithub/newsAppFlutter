import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_home_layout/news_app_cubit/cubit.dart';
import 'package:news_app/layout/news_home_layout/news_home_layout.dart';
import 'package:news_app/network/cach_helper.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/mode_cubit/cubit.dart';
import 'package:news_app/shared/mode_cubit/state.dart';
import 'package:news_app/shared/styles/themes.dart';


void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // BlocOverrides.runZoned(
  //       () {},
  //   blocObserver: MyBlocObserver() ,
  // );
  DioHelper.init();
  await CacheHelper.init();

  late bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  runApp(Myapp(
   // startWidget: widget ,
    isDark: isDark,
  ));
}

class Myapp extends StatelessWidget {
  final  bool? isDark;

  const Myapp({Key? key,
    this.isDark}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ModeCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ) ,
        BlocProvider(
            create: (context) =>
            NewsCubit()..getBusiness()
        ),
      ],
      child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ModeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const NewsAppHome(),
          );
        },
      ),
    );
  }
}
