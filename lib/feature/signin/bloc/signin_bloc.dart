import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:ringkasan_buku/feature/signin/bloc/signin_event.dart';
import 'package:ringkasan_buku/feature/signin/bloc/signin_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/bloc/authentication_bloc.dart';
import '../authentication/bloc/authentication_event.dart';
import '../authentication/model/user_login.dart';
import '../resource/auth_repository.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  SignInBloc({@required this.authRepository, @required this.authenticationBloc})
      : assert(authRepository != null),
        assert(authenticationBloc != null);

  @override
  SignInState get initialState => SignInInitial();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInButtonPressed) {
      try {
        yield SignInLoading();
        String tokenFcm = "";
        String deviceType = "";
        String deviceId = "";
        String deviceName = "";
        String deviceInformation = "";

        var deviceInfoPlugin = DeviceInfoPlugin();
        final deviceInfo = await deviceInfoPlugin.deviceInfo;
        final allInfo = deviceInfo.data;

        if (defaultTargetPlatform == TargetPlatform.iOS) {
          FirebaseMessaging messaging = FirebaseMessaging.instance;
          NotificationSettings settings = await messaging.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );
          print('User granted permission: ${settings.authorizationStatus}');
          tokenFcm = await messaging.getToken();
          deviceType = await Platform.operatingSystem;
          var iosDeviceInfo = await deviceInfoPlugin.iosInfo;
          deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
          deviceName = iosDeviceInfo.utsname.machine;
        }
        if (defaultTargetPlatform == TargetPlatform.android) {
          FirebaseMessaging messaging = FirebaseMessaging.instance;
          messaging.getToken().then((value) {
            tokenFcm = value;
          }, onError: (err) => print(err.message))
            ..catchError((onError) => print(onError.message));
          deviceType = await Platform.operatingSystem;
          var androidDeviceInfo = await deviceInfoPlugin.androidInfo;
          deviceId = await PlatformDeviceId.getDeviceId; // unique ID on Android
          deviceName = androidDeviceInfo.model;
        }
        deviceInformation = allInfo.toString();

        await Future.delayed(const Duration(seconds: 1));
        final response = await authRepository.signIn(
            event.email,
            event.password,
            tokenFcm,
            deviceType,
            deviceId,
            deviceName,
            deviceInformation);
        if (response.success == false) {
          yield SignInFailure(error: response.message);
          yield SignInInitial();
        }
        if (response.success == true) {
          String token = response.token;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);
          UserLogin user = UserLogin.fromjson(response.user);
          authenticationBloc.add(LoggedIn(
              token: token,
              userEmail: user.email,
              userId: user.id,
              username: user.name));
          yield SignInSuccess();
        }
      } catch (error) {
        if (error.toString().contains("Unauthorized")) {
          yield SignInFailure(error: "Wrong Email or Password!");
          yield SignInInitial();
        } else {
          yield SignInFailure(error: error.toString());
        }
      }
    }
  }
}
