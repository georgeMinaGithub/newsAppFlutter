
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/components.dart';

import '../../../layout/news_home_layout/news_app_cubit/cubit.dart';
import '../../../layout/news_home_layout/news_app_cubit/states.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        var list = NewsCubit.get(context).business;
        return articleBuilder(list,context);

      },

    );
  }
}