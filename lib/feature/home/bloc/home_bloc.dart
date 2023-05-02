import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../resource/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int page = 1;
  int currentIndex = 0;
  int productCount;

  final HomeRepository homeRepository;

  HomeBloc({@required this.homeRepository}) : assert(homeRepository != null);

  @override
  HomeState get initialState => HomeLoading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    final HomeState currentState = state;

    if (event is HomeStarted) {
      page = 1;
      yield HomeLoading();
      try {
        // final response = await homeRepository.getHomeAppData(page);
        // final getStatus = await homeRepository.getStatusProductData();
        // print(response.success);
        // if (response.success == false) {
        //   if (response.message == "unauthenticated.") {
        //     yield HomeExpired(response.message);
        //   } else {
        //     yield HomeFailure(response.message);
        //   }
        // }
        // if (response.success == true) {
        //   product = response.data;
        //
        //   Status countStatus = Status.fromJson(getStatus.data);
        yield HomeLoaded(
            // product: product,
            // productActive: productActive,
            // productExpiring: productExpiring,
            // productExpired: productExpired,
            // reachMax: false,
            // activeCount: countStatus.active,
            // expiringCount: countStatus.expiring,
            // expiredCount: countStatus.expired,
            // inWarrantyCount: countStatus.in_warranty,
            );
        // }
      } catch (e) {
        if (e.toString() ==
            "Error During Communication: No internet connection") {
          yield ConnectionError();
        } else if (e.toString() == "Gateway Timeout: Request Timeout") {
          yield RequestTimeout();
        }
        yield HomeFailure(e.toString());
      }
    }
  }
}
