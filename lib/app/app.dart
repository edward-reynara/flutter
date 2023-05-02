import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ringkasan_buku/app/theme.dart';
import '../component/bloc/conectivity/connectivity_bloc.dart';
import '../component/helper/env.dart';
import '../component/helper/internet_check.dart';
import '../component/helper/localization.dart';
import '../component/http/http_provider.dart';
import '../component/navigation/route_generator.dart';
import '../component/resource/device/device_repository.dart';
import '../component/resource/general/general_repository.dart';
import '../feature/home/bloc/home_bloc.dart';
import '../feature/home/bloc/home_event.dart';
import '../feature/home/resource/home_repository.dart';
import '../feature/landing_page.dart';
import '../feature/signin/authentication/bloc/authentication_bloc.dart';
import '../feature/signin/authentication/bloc/authentication_event.dart';
import '../feature/signin/authentication/resource/authentication_repository.dart';
import '../main.dart';

class App extends StatelessWidget {
  final Env env;

  const App({Key key, @required this.env}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Env>(
          create: (context) => env,
          lazy: true,
        ),
        RepositoryProvider<InternetCheck>(
          create: (context) => InternetCheck(),
          lazy: true,
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
          lazy: true,
        ),
        RepositoryProvider<HttpProvider>(
          create: (context) => HttpProvider(),
          lazy: true,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityBloc>(
            create: (context) {
              return ConnectivityBloc();
            },
          ),
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              return AuthenticationBloc(
                  deviceRepository: DeviceRepository(
                    apiProvider: RepositoryProvider.of<HttpProvider>(context),
                    env: RepositoryProvider.of<Env>(context),
                  ),
                  generalRepository: GeneralRepository(
                    apiProvider: RepositoryProvider.of<HttpProvider>(context),
                    env: RepositoryProvider.of<Env>(context),
                  ),
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context))
                ..add(AuthStarted());
            },
          ),
          BlocProvider<HomeBloc>(
            create: (context) {
              return HomeBloc(
                homeRepository: HomeRepository(
                  apiProvider: RepositoryProvider.of<HttpProvider>(context),
                  env: RepositoryProvider.of<Env>(context),
                ),
              )..add(HomeStarted());
            },
          ),
          // BlocProvider<ExpiredHomeBloc>(
          //   create: (context) {
          //     return ExpiredHomeBloc(
          //       homeRepository: HomeRepository(
          //         apiProvider: RepositoryProvider.of<HttpProvider>(context),
          //         env: RepositoryProvider.of<Env>(context),
          //       ),
          //     )..add(ExpiredHomeStarted());
          //   },
          // ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const <
              LocalizationsDelegate<WidgetsLocalizations>>[
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback:
              S.delegate.resolution(fallback: const Locale('en', '')),
          localeListResolutionCallback:
              S.delegate.listResolution(fallback: const Locale('en', '')),
          title: "Home",
          theme: basicTheme,
          onGenerateRoute: RouteGenerator.generateRoute,
          // initialRoute: Routes.landing,
          // home: isviewed != 0 ? OnBoardingPage() : LandingPage(),
          home: LandingPage(),
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LandingPage()),
    );
    // Navigator.of(context).pushNamedAndRemoveUntil(
    //     Routes.landing, (Route<dynamic> route) => false);
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    // return IntroductionScreen(
    //   key: introKey,
    //   globalBackgroundColor: Colors.white,
    //   autoScrollDuration: 3000,
    //   pages: [
    //     PageViewModel(
    //       title: "Free Cloud Sync",
    //       body: "All data is stored and backed up in the cloud.",
    //       image: _buildImage('warranty_01.png'),
    //       decoration: pageDecoration,
    //     ),
    //     PageViewModel(
    //       title: "Push Notifications",
    //       body:
    //           "Get a push notification before a warranty is about to expires.",
    //       image: _buildImage('warranty_02.png'),
    //       decoration: pageDecoration,
    //     ),
    //     PageViewModel(
    //       title: "Never lose that receipt",
    //       body: "View the receipt anytime and anywhere.",
    //       image: _buildImage('warranty_03.png'),
    //       decoration: pageDecoration,
    //     ),
    //   ],
    //   showSkipButton: true,
    //   onDone: () => _onIntroEnd(context),
    //   onSkip: () => _onIntroEnd(context),
    //   back: const Icon(Icons.arrow_back, color: Colors.white),
    //   skip: const Text('Skip',
    //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    //   next: const Icon(Icons.arrow_forward, color: Colors.white),
    //   done: const Text('Done',
    //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
    //   curve: Curves.fastLinearToSlowEaseIn,
    //   controlsMargin: const EdgeInsets.all(16),
    //   controlsPadding: kIsWeb
    //       ? const EdgeInsets.all(12.0)
    //       : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
    //   dotsDecorator: const DotsDecorator(
    //     size: Size(10.0, 10.0),
    //     color: Colors.grey,
    //     activeColor: Colors.white,
    //     activeSize: Size(22.0, 10.0),
    //     activeShape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(25.0)),
    //     ),
    //   ),
    //   dotsContainerDecorator: const ShapeDecoration(
    //     color: Color.fromRGBO(2, 79, 137, 1),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
    //     ),
    //   ),
    // );
  }
}
