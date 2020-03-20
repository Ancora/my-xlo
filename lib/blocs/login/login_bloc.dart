import 'package:myxlo/blocs/login/button_state.dart';
import 'package:myxlo/blocs/login/field_state.dart';
import 'package:myxlo/blocs/login/login_bloc_state.dart';
import 'package:myxlo/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with LoginValidator {
  final BehaviorSubject<LoginBlocState> _stateController =
      BehaviorSubject<LoginBlocState>.seeded(LoginBlocState(LoginState.IDLE));
  final BehaviorSubject<String> _emailController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<LoginBlocState> get outState => _stateController.stream;
  Stream<FieldState> get outEmail => Rx.combineLatest2(
          _emailController.stream.transform(emailValidator), outState, (e, s) {
        e.enabled = s.state != LoginState.LOADING;
        return e;
      });
  Stream<FieldState> get outPassword => Rx.combineLatest2(
          _passwordController.stream.transform(passwordValidator), outState,
          (p, s) {
        p.enabled = s.state != LoginState.LOADING;
        return p;
      });
  Stream<ButtonState> get outLoginButton =>
      Rx.combineLatest3(outEmail, outPassword, outState, (e, p, s) {
        return ButtonState(
            loading: s.state == LoginState.LOADING,
            enabled: e.error == null &&
                p.error == null &&
                s.state != LoginState.LOADING);
      });

  void loginWithEmail() async {
    _stateController.add(LoginBlocState(LoginState.LOADING));

    await Future.delayed(Duration(seconds: 3));

    _stateController.add(LoginBlocState(LoginState.DONE));
  }

  void dispose() {
    _stateController.close();
    _emailController.close();
    _passwordController.close();
  }
}
