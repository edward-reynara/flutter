import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/Pallete.dart';
import '../../../component/helper/general_helper.dart';
import '../../../component/widget/loading_widget.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeForm extends StatefulWidget {
  final GeneralHelper helper;
  final bool reachMax;

  HomeForm({Key key, @required this.helper, @required this.reachMax})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;

  _HomeFormState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    print("__nepage");
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
    print("Load data home");
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }

    BlocProvider.of<HomeBloc>(context).add(NewPageProduct());
    print("__newpageproducts");
    Future.delayed(Duration(seconds: 3, milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(listener: (context, state) {
      if (state is HomeSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${state.message}'),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      }
      if (state is HomeFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${state.message}'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }, child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeLoading) {
        return LoadingWidget(visible: true);
      } else {
        return null;
      }
    }));
  }

  Decoration boxdecor() {
    return BoxDecoration(
      color: Palette.blueNavy,
      borderRadius: BorderRadius.circular(15),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    );
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
