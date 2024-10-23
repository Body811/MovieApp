import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/Movies/presentation/cubit/movies_cubit.dart';
import 'package:movie_app/features/Movies/presentation/cubit/search_movies_cubit.dart';
import 'package:movie_app/features/Movies/presentation/pages/MainScreen_page.dart';
import 'package:movie_app/features/Movies/presentation/pages/SearchScreen_page.dart';
import 'package:movie_app/features/details/presentation/pages/movie_details_screen.dart';
import 'package:movie_app/features/user_profile/edit_profile.dart';
import 'config/strings/app_strings.dart';
import 'config/theme/app_theme.dart';
import 'core/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/Movies/presentation/pages/HomeScreen_page.dart';
import 'features/Movies/presentation/pages/NoInternet_page.dart';
import 'features/Movies/presentation/pages/SplashScreen_page.dart';
import 'features/auth/presentation/authenticationPages/login.dart';
  import 'features/Movies/presentation/pages/SearchScreen_page.dart';
  import 'package:movie_app/features/favorite/presentation/favorite.dart';
  import 'features/details/presentation/pages/movie_details_screen.dart';
  import 'features/user_profile/user_profile.dart';


import 'package:movie_app/firebase_options.dart';

import 'features/user_profile/user_profile.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<MoviesCubit>()),
        BlocProvider(create: (_) => di.sl<SearchMoviesCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme(),
        title: AppStrings.appTitle,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => HomeScreen(),
          '/noInternet': (context) => const NoInternetPage(),
          '/login': (context) =>  Login(),
          '/main': (context) => MainScreen(),
          '/search': (context) => SearchScreen(),
          '/editProfile': (context) => EditProfile(),
          '/profile': (context) => UserProfile()
        },
        onGenerateRoute: (settings) {
          // Handle dynamic routes like 'details/1' or 'details/5'
          if (settings.name!.startsWith('/details/')) {
          final id = settings.name!.replaceFirst('/details/', '');
          return MaterialPageRoute(
          builder: (context) {
          return MovieDetailsScreen(movieId: int.parse(id));  // Pass the dynamic id
              },
            );
          }
          return null;
        }
      )
    );
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<MoviesCubit>()),
          BlocProvider(create: (_) => di.sl<SearchMoviesCubit>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(),
          title: AppStrings.appTitle,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/main':  (context) => const MainScreen(),
            '/home': (context) => HomeScreen(),
            '/noInternet': (context) => const NoInternetPage(),
            '/login': (context) => Login(),
            '/search': (context) => SearchScreen(),
            '/favorite': (context) => FavouriteScreen(),
            '/profile': (context) => UserProfile(userName: 'havana'),
          },
          onGenerateRoute: (settings) {
            if (settings.name!.startsWith('/details/')) {
              final id = settings.name!.replaceFirst('/details/', '');
              return MaterialPageRoute(
                builder: (context) {
                  return MovieDetailsScreen(movieId: int.parse(id));
                },
              );
            }
            return null;
          },
        ),
      );
    }
  }
