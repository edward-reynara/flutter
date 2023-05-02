import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../component/helper/localization.dart';
import '../../../component/helper/restart_app.dart';
import '../../../component/navigation/routes.dart';
import '../../../component/widget/loading_widget.dart';
import '../../landing_page.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  void _onSignUpButtonPressed() {
    FocusScope.of(context).unfocus();
    if (emailController.text == "" &&
        passwordController.text == "" &&
        nameController.text == "" &&
        passwordConfirmController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All field is empty!"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } else if (emailController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email is empty!"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } else if (passwordController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is empty!"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } else if (nameController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name is empty!"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } else if (!(emailController.text.contains("@"))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Wrong type of email!"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } else {
      BlocProvider.of<SignUpBloc>(context).add(
        SignUpButtonPressed(
            email: emailController.text,
            password: passwordController.text,
            confirm_password: passwordConfirmController.text,
            name: nameController.text),
      );
    }
  }

  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.message}'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          if (state is SignUpLoading) {
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
                              child: Image.asset(
                                "assets/images/app_icon2.png",
                                height: 120,
                                width: 240,
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                            SizedBox(height: 40),
                            inputTextField(
                                S.of(context).strName,
                                nameController,
                                Icons.person,
                                TextInputType.text),
                            SizedBox(height: 20),
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
                            SizedBox(height: 20),
                            inputPasswordConfirmationField(
                                S.of(context).strConfirmPassword,
                                passwordConfirmController,
                                Icons.password,
                                TextInputType.visiblePassword),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  const SizedBox(height: 30),
                                  Container(
                                    height: 40,
                                    child: _registerButton(state),
                                  ),
                                ]),
                          ]))),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
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
          hintStyle:
              TextStyle(color: Colors.white, fontFamily: "WorkSansLight"),
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
          hintStyle:
              TextStyle(color: Colors.white, fontFamily: "WorkSansLight"),
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

  Widget inputPasswordConfirmationField(
      String labelText,
      TextEditingController controller,
      IconData iconData,
      TextInputType keyboardType) {
    return TextFormField(
      obscureText: !this.showConfirmPassword,
      decoration: InputDecoration(
          contentPadding: new EdgeInsets.symmetric(),
          prefixIcon: Icon(iconData, color: Colors.black12),
          suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye,
                  color: this.showConfirmPassword ? Colors.green : Colors.grey),
              onPressed: () {
                setState(
                    () => this.showConfirmPassword = !this.showConfirmPassword);
              }),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          hintStyle:
              TextStyle(color: Colors.white, fontFamily: "WorkSansLight"),
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

  Widget inputField(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Align(
                widthFactor: 3.0,
                heightFactor: 3.0,
                child: Icon(iconData),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  Widget _registerButton(SignUpState state) {
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
              onPressed:
                  state is! SignUpLoading ? _onSignUpButtonPressed : null,
              child: Text(S.of(context).strRegister),
            )));
  }
}
