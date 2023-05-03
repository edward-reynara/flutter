import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ringkasan_buku/component/navigation/routes.dart';
import '../../feature/home/bloc/home_bloc.dart';
import '../../feature/home/bloc/home_event.dart';
import '../../feature/home/resource/home_repository.dart';
import '../../feature/home/ui/home_page.dart';
import '../../feature/landing_page.dart';
import '../../feature/main/bottom_navigation/bottom_navigation_bloc.dart';
import '../../feature/main/bottom_navigation/bottom_navigation_event.dart';
import '../../feature/main/ui/main_page.dart';
import '../../feature/signin/authentication/bloc/authentication_bloc.dart';
import '../../feature/signin/authentication/bloc/authentication_event.dart';
import '../helper/env.dart';
import '../http/http_provider.dart';
import '../resource/device/device_repository.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.landing:
        return MaterialPageRoute<dynamic>(builder: (_) => LandingPage());

      case Routes.signIn:
        // if (args is AuthRepository) {
        //   return MaterialPageRoute<dynamic>(
        //       builder: (_) => SignInPage(authRepository: args));
        // }
        return _errorRoute();

      case Routes.logout:
        return MaterialPageRoute(builder: (BuildContext context) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          return LandingPage();
        });

      case Routes.mainPage:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
                  create: (context) {
                    return BottomNavigationBloc(
                        deviceRepository: DeviceRepository(
                          apiProvider:
                              RepositoryProvider.of<HttpProvider>(context),
                          env: RepositoryProvider.of<Env>(context),
                        ),
                        homeRepository: HomeRepository(
                          apiProvider:
                              RepositoryProvider.of<HttpProvider>(context),
                          env: RepositoryProvider.of<Env>(context),
                        ))
                      ..add(PageStarted());
                  },
                  child: MainPage(),
                ));

      case Routes.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => RepositoryProvider(
            create: (context) => HomeRepository(
                apiProvider: RepositoryProvider.of<HttpProvider>(context),
                env: RepositoryProvider.of<Env>(context)),
            child: BlocProvider(
              create: (context) {
                return HomeBloc(
                  homeRepository: HomeRepository(
                    apiProvider: RepositoryProvider.of<HttpProvider>(context),
                    env: RepositoryProvider.of<Env>(context),
                  ),
                )..add(HomeStarted());
              },
              child: HomePage(),
            ),
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
