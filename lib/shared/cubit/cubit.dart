import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen/business_screen.dart';
import 'package:news_app/modules/science_screen/science_screen.dart';
import 'package:news_app/modules/sport_screen/sport_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> listNavBottom = const [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sorts'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  int currentIndex = 0;
  changeIndexNavBar(index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getSciences();

    emit(NewsChangeIndexNavBarState());
  }

  List<Widget> screens = [BusinessScreen(), SportScreen(), ScienceScreen()];

  List business = [];

  Future<dynamic> getBusiness() async {
    emit(NewsGetBusinessLoadingState());
    await DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '85aff49ad9d34837834d937bd20ce637',
    }).then((value) {
      business = value.data['articles'];
      // print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }

  List sports = [];

  Future<dynamic> getSports() async {
    if (sports.length == 0) {
      emit(NewsGetSportLoadingState());
      await DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '85aff49ad9d34837834d937bd20ce637',
      }).then((value) {
        sports = value.data['articles'];
        // print(sports[0]['title']);
        emit(NewsGetSportSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportErrorState(error));
      });
    } else {
      emit(NewsGetSportSuccessState());
    }
  }

  List sciences = [];

  Future<dynamic> getSciences() async {
    if (sciences.length == 0) {
      emit(NewsGetScienceLoadingState());
      await DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '85aff49ad9d34837834d937bd20ce637',
      }).then((value) {
        sciences = value.data['articles'];
        // print(sciences[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isLight = true;

  changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isLight = fromShared;
      emit(NewsChangeAppModeState());
    } else {
      isLight = !isLight;
      CacheHelper.putBoolean(key: 'isLight', value: isLight);
      emit(NewsChangeAppModeState());
    }
  }

  List search = [];

  Future<dynamic> getSearch(value) async {
    emit(NewsGetSearchLoadingState());
    await DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'q': '$value',
      'apiKey': '85aff49ad9d34837834d937bd20ce637',
    }).then((value) {
      search = value.data['articles'];
      // print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });
  }
}
