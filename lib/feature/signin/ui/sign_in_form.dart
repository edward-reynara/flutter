import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../component/helper/env.dart';
import '../../../component/helper/internet_check.dart';
import '../../../component/helper/localization.dart';
import '../../../component/http/http_provider.dart';
import '../../../component/widget/loading_widget.dart';
import '../../signup/ui/sign_up_page.dart';
import '../bloc/signin_bloc.dart';
import '../bloc/signin_event.dart';
import '../bloc/signin_state.dart';
import '../resource/auth_repository.dart';

class SignInForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onLoginButtonPressed() {
    FocusScope.of(context).unfocus();
    if (emailController.text == "" && passwordController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email and Password is empty!"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else if (emailController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email is empty!"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else if (passwordController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is empty!"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else if (!(emailController.text.contains("@"))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Wrong type of email!"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } else {
      BlocProvider.of<SignInBloc>(context).add(
        SignInButtonPressed(
            email: emailController.text, password: passwordController.text),
      );
    }
  }

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          if (state is SignInLoading) {
            return LoadingWidget(visible: true);
          } else {
            return Stack(
              children: <Widget>[
                Container(),
                SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Column(children: <Widget>[
                            SizedBox(height: 70),
                            Container(
                              child: Image.asset("assets/images/app_icon2.png",
                                  height: 120, width: 240),
                            ),
                            SizedBox(height: 40),
                            inputTextField(
                                S.of(context).strEmail,
                                emailController,
                                Icons.email,
                                TextInputType.emailAddress),
                            SizedBox(height: 20),
                            inputPasswordField(
                                S.of(context).strPassword,
                                passwordController,
                                Icons.password,
                                TextInputType.visiblePassword),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const SizedBox(height: 30),
                                  Container(
                                    height: 40,
                                    child: _signInButton(state),
                                  ),
                                ]),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const SizedBox(height: 40),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("Don't have an account?",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Poppins")),
                                        const SizedBox(height: 10),
                                        Container(
                                          height: 40,
                                          child: _signUpButton(state),
                                        ),
                                      ]),
                                ]),
                          ]))),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget _signInButton(SignInState state) {
    final ButtonStyle style = OutlinedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Theme.of(context).primaryColor);
    return Padding(
        padding: EdgeInsets.only(left: 0.0, right: 0.0),
        child: ButtonTheme(
            minWidth: 200.0,
            height: 100.0,
            child: ElevatedButton(
              style: style,
              onPressed: state is! SignInLoading ? _onLoginButtonPressed : null,
              child: Text(S.of(context).strLogin),
            )));
  }

  Widget _signUpButton(SignInState state) {
    final ButtonStyle style = OutlinedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Theme.of(context).primaryColor);
    return Padding(
        padding: EdgeInsets.only(left: 0.0, right: 0.0),
        child: ButtonTheme(
            minWidth: 200.0,
            height: 100.0,
            child: ElevatedButton(
              style: style,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpPage(
                          authRepository: AuthRepository(
                              env: RepositoryProvider.of<Env>(context),
                              apiProvider:
                                  RepositoryProvider.of<HttpProvider>(context),
                              internetCheck:
                                  RepositoryProvider.of<InternetCheck>(
                                      context)))),
                );
              },
              child: Text(S.of(context).strSignUp),
            )));
  }

  Widget inputTextField(String labelText, TextEditingController controller,
      IconData iconData, TextInputType keyboardType) {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.symmetric(),
          prefixIcon: Icon(iconData, color: Colors.black12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white24,
          labelText: labelText,
          floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
            final Color color = states.contains(MaterialState.focused)
                ? Theme.of(context).primaryColor
                : Colors.black54;
            return TextStyle(color: color);
          })),
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: controller,
    );
  }

  Widget inputPasswordField(String labelText, TextEditingController controller,
      IconData iconData, TextInputType keyboardType) {
    return TextFormField(
      obscureText: !this.showPassword,
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.symmetric(),
          prefixIcon: Icon(iconData, color: Colors.black12),
          suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye,
                  color: this.showPassword ? Colors.green : Colors.grey),
              onPressed: () {
                setState(() => this.showPassword = !this.showPassword);
              }),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white24,
          labelText: labelText,
          floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
            final Color color = states.contains(MaterialState.focused)
                ? Theme.of(context).primaryColor
                : Colors.black54;
            return TextStyle(color: color);
          })),
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: controller,
    );
  }
}
