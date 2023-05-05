import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/Pallete.dart';
import '../../../../component/helper/general_helper.dart';
import '../bloc/tabbar_genre_bloc.dart';
import '../bloc/tabbar_genre_event.dart';

class GenreTab extends StatefulWidget {
  // final List<Transaction> data;
  final GeneralHelper helper;
  final bool reachMax;

  GenreTab({@required this.helper, @required this.reachMax});

  @override
  State<StatefulWidget> createState() => _GenreTab();
}

class _GenreTab extends State<GenreTab> {
  bool isLoading = false;
  // List<Transaction> tempList;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    // tempList = widget.data;
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (!widget.reachMax && !isLoading) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
          loadData();
        });
      }
    }
  }

  void loadData() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    BlocProvider.of<TabBarGenreBloc>(context).add(NewItems());
    Future.delayed(Duration(seconds: 3, milliseconds: 500), () {
      // tempList += widget.data;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<TabBarGenreBloc>(context).add(
            TabStarted(),
          );
        },
        child: Scrollbar(
            child: Container(
                color: Palette.whiteBg,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    // itemCount:
                    //     widget.reachMax ? tempList.length : tempList.length + 1,
                    itemBuilder: (context, index) {
                      // if (index == tempList.length && !widget.reachMax) {
                      //   return buildProgressIndicator();
                      // } else {
                      return Container(
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.07),
                              blurRadius: 5,
                            )
                          ]),
                          child: Card(
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8.0),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              // (index + 1).toString() +
                                              //     ". " +
                                              // tempList[index].orderId,
                                              "data",
                                              style: TextStyle(fontSize: 13)),
                                          SizedBox(height: 5)
                                        ]),
                                  ),
                                  separate(5),
                                  // tempList[index].details.length > 0
                                  //     ? SizedBox()
                                  //     : Container(),
                                ],
                              ),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           TransactionDetail(
                                //             data: tempList[index],
                                //             helper: GeneralHelper(),
                                //           )),
                                // );
                              },
                            ),
                          ));
                    }
                    // }
                    ))));
  }

  Widget separate(double height) {
    return Container(
        color: Colors.black12,
        height: 1.5,
        margin: EdgeInsets.only(top: height, bottom: height));
  }

  Widget buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
