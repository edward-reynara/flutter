import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../component/widget/alert_widget.dart';
import '../../../component/widget/loading_widget.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isLoading = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text(
        //     "Home",
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   iconTheme: IconThemeData(color: Colors.white),
        //   backgroundColor: Theme.of(context).primaryColor,
        //   actions: [
        //     Padding(
        //         padding: EdgeInsets.only(right: 8),
        //         child: IconButton(
        //           onPressed: () {},
        //           icon: Icon(Icons.notifications, color: Colors.white),
        //         ))
        //   ],
        // ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeLoading) {
        return LoadingWidget(visible: true);
      }
      if (state is HomeSuccess) {
        return LoadingWidget(visible: false);
      }
      if (state is HomeFailure) {
        return LoadingWidget(visible: false);
      }
      if (state is HomeExpired) {
        return AlertWidget();
      }
      if (state is HomeLoaded) {
        LoadingWidget(visible: false);
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Material(
                  child: TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    controller: _tabController,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'ACTIVE'),
                      Tab(text: 'EXPIRING'),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // //Content Tab Home Active
                        // BlocProvider(
                        //   create: (context) {
                        //     return ActiveHomeBloc(
                        //       homeRepository: HomeRepository(
                        //         apiProvider:
                        //         RepositoryProvider.of<HttpProvider>(
                        //             context),
                        //         env: RepositoryProvider.of<Env>(context),
                        //       ),
                        //     )..add(ActiveHomeStarted());
                        //   },
                        //   child: HomeActivePage(),
                        // ),
                        // //Content Tab Home Expiring
                        // BlocProvider(
                        //   create: (context) {
                        //     return ExpiringHomeBloc(
                        //       homeRepository: HomeRepository(
                        //         apiProvider:
                        //         RepositoryProvider.of<HttpProvider>(
                        //             context),
                        //         env: RepositoryProvider.of<Env>(context),
                        //       ),
                        //     )..add(ExpiringHomeStarted());
                        //   },
                        //   child: HomeExpiringPage(),
                        // ),
                        // // HomeExpiredPage(),
                        // //Content Tab Home Expired
                        // BlocProvider(
                        //   create: (context) {
                        //     return ExpiredHomeBloc(
                        //       homeRepository: HomeRepository(
                        //         apiProvider:
                        //         RepositoryProvider.of<HttpProvider>(
                        //             context),
                        //         env: RepositoryProvider.of<Env>(context),
                        //       ),
                        //     )..add(ExpiredHomeStarted());
                        //   },
                        //   child: HomeExpiredPage(),
                        // ),
                      ],
                    ))
              ],
            ));
      }
      if (state is ExpiredLoaded) {
        LoadingWidget(visible: false);
        // print("__Loaded_state:" + state.product[0].id.toString());
        Center(
          child: Text("SS"),
        );
      }
      return Center(
        child: Text("test"),
      );
    }));
  }
}
