import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../component/resource/device/device_repository.dart';
import '../../../../component/resource/general/general_repository.dart';
import '../resource/authentication_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  final DeviceRepository deviceRepository;
  // final SettingsRepository settingsRepository;
  final GeneralRepository generalRepository;

  AuthenticationBloc({
    @required this.authenticationRepository,
    @required this.deviceRepository,
    // @required this.settingsRepository,
    @required this.generalRepository,
  }) : assert(authenticationRepository != null, deviceRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationCheck();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthStarted) {
      // final hasToken = await authenticationRepository.hasToken();
      // if (responseUpdate.data == true) {
      //   yield AppUpdate();
      // }
      // if (hasToken) {
      // final responseUpdate = await generalRepository.deviceUpdate();
      // final getSettings = await settingsRepository.getSettingAppData();
      // if (getSettings.message == "unauthenticated.") {
      //   await authenticationRepository.deleteToken();
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   await prefs.remove('userEmail');
      //   await prefs.remove('username');
      //   await prefs.remove('token');
      //   await prefs.remove('version');
      //   // prefs.clear();
      //   yield Unauthenticated();
      // } else {
      yield Authenticated();
      // }
      // } else {
      //   yield Unauthenticated();
      // }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await authenticationRepository.persistToken(event.token);
      // String deviceId = await PlatformDeviceId.getDeviceId;
      // String deviceType = SysInfo.operatingSystemName;

      // //TODO SHARED PREF(
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setInt("userId", event.userId);
      await prefs.setString("userEmail", event.userEmail);
      await prefs.setString("username", event.username);
      // await prefs.setString("deviceId", deviceId);
      // await prefs.setString("deviceType", deviceType);
      //TODO SAVE DEVICE
      // await deviceRepository.deviceSave();
      yield Authenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      //TODO DELETE DEVICE
      await deviceRepository.deviceDelete();
      await authenticationRepository.deleteToken();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userEmail');
      await prefs.remove('username');
      await prefs.remove('token');
      await prefs.remove('version');
      // prefs.clear();
      yield Unauthenticated();
    }
  }
}
