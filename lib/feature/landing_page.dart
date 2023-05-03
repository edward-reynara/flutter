import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ringkasan_buku/feature/home/resource/home_repository.dart';
import 'package:ringkasan_buku/feature/signin/authentication/bloc/authentication_bloc.dart';
import 'package:ringkasan_buku/feature/signin/authentication/bloc/authentication_state.dart';

import '../component/helper/env.dart';
import '../component/http/http_provider.dart';
import '../component/resource/device/device_repository.dart';
import 'main/bottom_navigation/bottom_navigation_bloc.dart';
import 'main/bottom_navigation/bottom_navigation_event.dart';
import 'main/ui/main_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) async {
      // TODO Crashlytic
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }, builder: (context, state) {
      // if (state is AuthenticationLoading) {
      //   return LoadingWidget(visible: true);
      // }
      // if (state is AuthenticationCheck) {
      //   return LoadingWidget(visible: true);
      // }
      // // if (state is AppUpdate) {
      // //   LoadingWidget(visible: true);
      // //   return UpdateWidget();
      // // }
      // if (state is Authenticated) {
      //   LoadingWidget(visible: false);
      // NAVIGATE TO PUSH MAIN PAGE
      return BlocProvider(
        create: (context) {
          return BottomNavigationBloc(
              deviceRepository: DeviceRepository(
                apiProvider: RepositoryProvider.of<HttpProvider>(context),
                env: RepositoryProvider.of<Env>(context),
              ),
              homeRepository: HomeRepository(
                apiProvider: RepositoryProvider.of<HttpProvider>(context),
                env: RepositoryProvider.of<Env>(context),
              ))
            ..add(PageStarted());
        },
        child: MainPage(),
      );
      // }

      // if (state is Unauthenticated) {
      //   // return WelcomePage();
      //   return SignInPage(
      //       authRepository: AuthRepository(
      //           env: RepositoryProvider.of<Env>(context),
      //           apiProvider: RepositoryProvider.of<HttpProvider>(context),
      //           internetCheck: RepositoryProvider.of<InternetCheck>(context)));
      // }

      return null;
    });
  }
}
