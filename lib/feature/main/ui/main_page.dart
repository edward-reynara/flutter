import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../component/helper/env.dart';
import '../../../component/http/http_provider.dart';
import '../../../component/widget/loading_widget.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_event.dart';
import '../../home/resource/home_repository.dart';
import '../../home/ui/home_page.dart';
import '../bottom_navigation/bottom_navigation_bloc.dart';
import '../bottom_navigation/bottom_navigation_event.dart';
import '../bottom_navigation/bottom_navigation_state.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          BlocProvider.of<BottomNavigationBloc>(context)
              .add(BackButtonTapped(index: 0));

          return false;
        },
        child: Scaffold(
          body: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            builder: (context, state) {
              if (state is PageLoading) {
                return LoadingWidget(visible: true);
              }
              if (state is ExitPageLoaded) {
                return exit(0);
              }

              if (state is HomePageLoaded) {
                print('mainPage Loaded');
                LoadingWidget(visible: false);
                return RepositoryProvider(
                  create: (context) => HomeRepository(
                      apiProvider: RepositoryProvider.of<HttpProvider>(context),
                      env: RepositoryProvider.of<Env>(context)),
                  child: BlocProvider(
                    create: (context) {
                      return HomeBloc(
                        homeRepository: HomeRepository(
                          apiProvider:
                              RepositoryProvider.of<HttpProvider>(context),
                          env: RepositoryProvider.of<Env>(context),
                        ),
                      )..add(HomeStarted());
                    },
                    child: HomePage(),
                  ),
                );
              }

              return Container();
            },
          ),
          bottomNavigationBar:
              BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
            builder: (context, state) {
              return BottomNavigationBar(
                //fixedColor: Colors.red,
                unselectedItemColor: Colors.black54,
                selectedItemColor: Theme.of(context).primaryColor,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: true,
                unselectedFontSize: 8,
                selectedFontSize: 10,
                currentIndex:
                    BlocProvider.of<BottomNavigationBloc>(context).currentIndex,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        //color: Colors.indigo, size: 25
                      ),
                      label: "Perpustakaan"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                        //color: Colors.indigo, size: 25
                      ),
                      label: "Temukan"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.card_giftcard,
                        //color: Colors.indigo, size: 25
                      ),
                      label: "Hadiah"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list,
                        //color: Colors.indigo, size: 25
                      ),
                      label: "Genre"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.account_circle,
                        //color: Colors.indigo, size: 25
                      ),
                      label: "Profil"),
                ],
                onTap: (index) => BlocProvider.of<BottomNavigationBloc>(context)
                    .add(PageTapped(index: index)),
              );
            },
          ),
        ));
  }

  BottomNavigationBarItem addPageBarItem(BuildContext context) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              height: 56,
              width: 56,
              child: Icon(Icons.add, size: 40, color: Colors.white)),
        ),
        label: '');
  }
}
