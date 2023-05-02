import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'component/app_component.dart';
import 'component/bloc/simple_bloc_delegate.dart';
import 'component/helper/env.dart';
import 'component/helper/restart_app.dart';
import 'component/modules/PreferenceModule.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

AppComponent appComponent;

int isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    appComponent = await AppComponent.create(PreferenceModule());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isviewed = prefs.getInt('onBoard');
    runApp(RestartWidget(child: App(env: EnvValue.production)));
  });
}
