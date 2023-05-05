import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/resource/device/device_repository.dart';
import '../../home/resource/home_repository.dart';
import 'bottom_navigation_event.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  int currentIndex = 0;
  final DeviceRepository deviceRepository;
  int page = 1;
  final HomeRepository homeRepository;

  BottomNavigationBloc(
      {@required this.deviceRepository, @required this.homeRepository})
      : assert(deviceRepository != null, homeRepository != null);

  @override
  BottomNavigationState get initialState => PageLoading();

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String targetMenu = prefs.getString("target_menu");

    //TODO SAVE DEVICE
    // await deviceRepository.deviceSave();

    if (event is PageStarted) {
      //handle notification
      if (targetMenu != null) {
        if (targetMenu == "categories") {
          this.currentIndex = 1;
          prefs.remove("target_menu");
          yield CategoriesPageLoaded(text: "CATEGORIES");
        }

        if (targetMenu == "add") {
          this.currentIndex = 2;
          prefs.remove("target_menu");
          yield AddPageLoaded(text: "ADD");
        }

        if (targetMenu == "searchproduct") {
          this.currentIndex = 3;
          prefs.remove("target_menu");
          // yield SearchPageLoaded(text: "Search");
        }
      }
      this.add(PageTapped(index: this.currentIndex));
    }

    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      page = 1;
      // final getHomeAppData = await homeRepository.getHomeAppData(page);
      yield PageLoading();

      if (this.currentIndex == 0) {
        yield HomePageLoaded(text: "HOME", reachMax: false, status: "active");
      }

      if (this.currentIndex == 1) {
        yield CategoriesPageLoaded(text: "CATEGORIES");
      }

      if (this.currentIndex == 2) {
        yield AddPageLoaded(text: "ADD");
      }

      if (this.currentIndex == 3) {
        yield GenrePageLoaded(text: "GENRE");
      }

      if (this.currentIndex == 4) {
        yield SettingsPageLoaded(text: "SETTINGS");
      }
    }

    if (event is BackButtonTapped) {
      if (this.currentIndex == 0) {
        yield ExitPageLoaded();
      } else {
        this.currentIndex = event.index;
        yield CurrentIndexChanged(currentIndex: this.currentIndex);
        yield HomePageLoaded(text: "HOME");
      }
    }
  }
}
