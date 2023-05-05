import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ringkasan_buku/feature/genre/tabbar_genre/bloc/tabbar_genre_event.dart';
import 'package:ringkasan_buku/feature/genre/tabbar_genre/bloc/tabbar_genre_state.dart';
import '../../resource/genre_repository.dart';

class TabBarGenreBloc extends Bloc<TabBarGenreEvent, TabBarGenreState> {
  int currentIndex = 0;
  int page;

  // List<Transaction> trans;

  final GenreRepository genreRepository;

  TabBarGenreBloc({@required this.genreRepository})
      : assert(genreRepository != null);

  @override
  TabBarGenreState get initialState => TabLoading();

  @override
  Stream<TabBarGenreState> mapEventToState(TabBarGenreEvent event) async* {
    final TabBarGenreState currentState = state;
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // int appId = prefs.getInt("appId");

    if (event is TabStarted) {
      this.add(TabTapped(index: this.currentIndex));
      yield TabLoading();
    }

    if (event is TabTapped) {
      page = 1;
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield TabLoading();
      // if (appId == null) {
      //   yield EmptyTransaction(text: "Select your App first");
      // }
      // TODO Get All transaction
      if (this.currentIndex == 0) {
        try {
          // final response =
          //     await transactionRepository.getTransactionData(appId, 0, page);
          // if (response.status == Status.ConnectivityError) {
          //   yield ExpiredTransaction();
          // }
          // if (response.status == Status.NewToken) {
          //   final response =
          //       await transactionRepository.getTransactionData(appId, 0, page);
          //   trans = response.data;
          //   if (trans == null) {
          //     yield ExpiredTransaction();
          //   }
          //   if (trans.length == 0) {
          //     yield EmptyTransaction(text: "No data found for all transaction");
          //   } else {
          //     yield AllTransactionLoaded(trans: trans, reachMax: false);
          //   }
          // }
          // if (response.status == Status.Success) {
          //   trans = response.data;
          //   if (trans.length == 0) {
          //     yield EmptyTransaction(text: "No data found for all transaction");
          //   } else {
          yield AllGenreLoaded(reachMax: false);
          // }
          // }
        } catch (e) {}
      }

      // TODO Get transaction completed
      if (this.currentIndex == 1) {
        try {
          // final response =
          //     await transactionRepository.getTransactionData(appId, 7, page);
          // if (response.status == Status.ConnectivityError) {
          //   yield ConnectionError();
          // }
          //
          // if (response.status == Status.Success) {
          //   trans = response.data;
          //   if (trans.length == 0) {
          yield EmptyGenre(text: "No data found");
          //   } else {
          //     yield CompletedTransactionLoaded(
          //         trans: trans, busy: false, reachMax: false);
          //   }
          // }
        } catch (e) {
          if (e.toString() ==
              "Error During Communication: No internet connection") {
            yield ConnectionError();
          } else if (e.toString() == "Gateway Timeout: Request Timeout") {
            yield RequestTimeout();
          }
          print(e.toString());
        }
      }
    }

    // TODO Get New Items
    // if (event is NewItems) {
    //   // TODO Get New Items All Transaction
    //   if (currentState is AllTransactionLoaded) {
    //     try {
    //       if (!currentState.reachMax) {
    //         page += 1;
    //         final response =
    //             await transactionRepository.getTransactionData(appId, 0, page);
    //         if (response.status == Status.ConnectivityError) {
    //           yield ConnectionError();
    //         }
    //
    //         if (response.status == Status.Success) {
    //           trans = response.data;
    //           if (trans.length == 0) {
    //             yield AllTransactionLoaded(trans: [], reachMax: true);
    //           } else {
    //             yield AllTransactionLoaded(trans: trans, reachMax: false);
    //           }
    //         }
    //       }
    //     } catch (e) {
    //       print(e.toString());
    //     }
    //   }

    // TODO Get New Items Completed Transaction
    // if (currentState is CompletedTransactionLoaded) {
    //   try {
    //     if (!currentState.reachMax) {
    //       page += 1;
    //       final response =
    //           await transactionRepository.getTransactionData(appId, 7, page);
    //       if (response.status == Status.ConnectivityError) {
    //         yield ConnectionError();
    //       }
    //
    //       if (response.status == Status.Success) {
    //         trans = response.data;
    //         if (trans.length == 0) {
    //           yield CompletedTransactionLoaded(
    //               trans: [], busy: false, reachMax: true);
    //         } else {
    //           yield CompletedTransactionLoaded(
    //               trans: trans, busy: false, reachMax: false);
    //         }
    //       }
    //     }
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // }

    // }
  }
}
