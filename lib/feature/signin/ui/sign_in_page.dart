import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ringkasan_buku/feature/signin/ui/sign_in_form.dart';
import '../authentication/bloc/authentication_bloc.dart';
import '../bloc/signin_bloc.dart';
import '../resource/auth_repository.dart';

class SignInPage extends StatelessWidget {
  final AuthRepository authRepository;

  const SignInPage({Key key, this.authRepository})
      : assert(authRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RepositoryProvider(
      create: (context) => authRepository,
      child: BlocProvider(
        create: (context) {
          return SignInBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            authRepository: authRepository,
          );
        },
        child: SignInForm(),
      ),
    ));
  }
}
