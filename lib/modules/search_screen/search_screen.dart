import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextField(
                  controller: searchController,
                  keyboard: TextInputType.text,
                  onChange: (String value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'search must not be empty';
                    }
                    return null;
                  },
                  label: 'Search',
                  prefixIcon: Icons.search,
                ),
              ),
              Expanded(
                child: buildListItems(
                  list,
                  isSearch: true,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
