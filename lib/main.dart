import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/news_layout.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool? isLight = CacheHelper.getBoolean(key: 'isLight');

  

  runApp(MyApp(isLight));
}

class MyApp extends StatelessWidget {
  final bool? isLight;
  MyApp(this.isLight);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..changeAppMode(fromShared: isLight),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.grey,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                titleSpacing: 20.0,
                iconTheme: IconThemeData(color: Colors.black),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                elevation: 20.0,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Color(0xFF333739),
              primarySwatch: Colors.grey,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF333739),
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xFF333739),
                  statusBarIconBrightness: Brightness.light,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                titleSpacing: 20.0,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF333739),
                elevation: 20.0,
                selectedItemColor: Colors.white,
                unselectedItemColor: Color(0xFF8E8E8E),
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isLight
                ? ThemeMode.light
                : ThemeMode.dark,
            home: const NewsScreen(),
          );
        },
      ),
    );
  }
}
