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
      // if (state is EmptyHome) {
      //   LoadingWidget(visible: false);
      //   return Center(
      //       child: Text(state.text,
      //           textAlign: TextAlign.center,
      //           style: TextStyle(fontSize: 16)));
      // }
      if (state is HomeLoaded) {
        LoadingWidget(visible: false);
        Center(
          child: Text("SS"),
        );
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
