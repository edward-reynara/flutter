import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ringkasan_buku/feature/signup/bloc/signup_event.dart';
import 'package:ringkasan_buku/feature/signup/bloc/signup_state.dart';

import '../../signin/resource/auth_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({@required this.authRepository}) : assert(authRepository != null);

  @override
  SignUpState get initialState => SignUpInitial();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    final SignUpState currentState = state;

    if (event is SignUpButtonPressed) {
      try {
        yield SignUpLoading();
        final response = await authRepository.signUp(
            event.email, event.password, event.confirm_password, event.name);
        if (response.success == false) {
          yield SignUpFailure(error: response.message);
          yield SignUpInitial();
        }
        if (response.success == true) {
          yield SignUpSuccess(message: response.message);
          // await Future.delayed(Duration(seconds: 3));
          // yield SignUpFinish();
        }
      } catch (error) {}
    }
  }
}
