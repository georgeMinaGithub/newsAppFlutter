
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/component/components.dart';

import '../../../layout/news_home_layout/news_app_cubit/cubit.dart';
import '../../../layout/news_home_layout/news_app_cubit/states.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var searchController = TextEditingController();

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},

      builder: (context, state)
      {
        var list = NewsCubit.get(context).search;

        return Scaffold(

          appBar: AppBar(),

          body: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(20),
                child: defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  prefix: Icons.search,
                  onChanged: (String value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Enter What Do You Wont Search';
                    }
                    else
                    {
                      return null;
                    }
                  },
                ),
              ),

              Expanded(child: articleBuilder(list, context, isSearch: true)),
              
            ],
          ),
        );
      },

    );
  }
}
