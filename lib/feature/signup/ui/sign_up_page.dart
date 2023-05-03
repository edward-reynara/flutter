import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ringkasan_buku/feature/signup/ui/sign_up_form.dart';
import '../../signin/resource/auth_repository.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';

class SignUpPage extends StatelessWidget {
  final AuthRepository authRepository;

  const SignUpPage({Key key, this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Register",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor),
        resizeToAvoidBottomInset: false,
        body: RepositoryProvider(
          create: (context) => authRepository,
          child: BlocProvider(
            create: (context) {
              return SignUpBloc(
                authRepository: authRepository,
              )..add(SignUpStarted());
            },
            child: SignUpForm(),
          ),
        ));
  }
}
