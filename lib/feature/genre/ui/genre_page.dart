import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/Pallete.dart';
import '../../../component/helper/general_helper.dart';
import '../../../component/widget/alert_widget.dart';
import '../../../component/widget/loading_widget.dart';
import '../tabbar_genre/bloc/tabbar_genre_bloc.dart';
import '../tabbar_genre/bloc/tabbar_genre_event.dart';
import '../tabbar_genre/bloc/tabbar_genre_state.dart';
import '../tabbar_genre/ui/genre_tab.dart';

class GenrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int tabIndex = 0;

    return DefaultTabController(
        length: 5,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("Genre", style: TextStyle(color: Colors.white)),
              bottom: TabBar(
                  onTap: (index) {
                    tabIndex = index;
                    BlocProvider.of<TabBarGenreBloc>(context)
                        .add(TabTapped(index: index));
                  },
                  isScrollable: true,
                  labelColor: Palette.blueNavy,
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          // topLeft: Radius.circular(10),
                          // topRight: Radius.circular(10)
                          ),
                      color: Colors.white),
                  tabs: [
                    new Tab(text: "Semua"),
                    new Tab(text: "Perempuan"),
                  ]),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => BlocProvider(
                    //           create: (context) {
                    //             return SearchTransactionBloc(
                    //                 transactionRepository:
                    //                     TransactionRepository(
                    //                         env: RepositoryProvider.of<Env>(
                    //                             context),
                    //                         apiProvider: RepositoryProvider.of<
                    //                             HttpProvider>(context)))
                    //               ..add(SearchStarted());
                    //           },
                    //           child: SearchTransactionPage(
                    //               tabIndex: tabIndex,
                    //               helper: GeneralHelper()))),
                    // );
                  },
                ),
              ],
            ),
            body: BlocBuilder<TabBarGenreBloc, TabBarGenreState>(
              builder: (context, state) {
                if (state is TabLoading) {
                  return LoadingWidget(visible: true);
                } else if (state is EmptyGenre) {
                  return Center(
                      child: Text(state.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16)));
                } else if (state is ExpiredGenre) {
                  return AlertWidget();
                } else if (state is AllGenreLoaded) {
                  return GenreTab(
                      // data: state.trans,
                      helper: GeneralHelper(),
                      reachMax: state.reachMax);
                } else if (state is PerempuanGenreLoaded) {
                  return GenreTab(
                      // data: state.trans,
                      helper: GeneralHelper(),
                      reachMax: state.reachMax);
                }
                //no internet + request timeout
                else if (state is ConnectionError) {
                  return refresh("", context);
                } else if (state is RequestTimeout) {
                  return refresh("Request Timeout", context);
                }
                return Container();
              },
            )));
  }

  //refresh beta
  Center refresh(String text, context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        // RaisedButton(
        //     child: Text("Refresh", style: TextStyle(color: Colors.white)),
        //     onPressed: () => BlocProvider.of<TabBarGenreBloc>(context)
        //         .add(TabStarted()))
      ],
    ));
  }
}
