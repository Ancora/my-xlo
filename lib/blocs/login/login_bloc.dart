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
  Stream<FieldState> get outEmail =>
      _emailController.stream.transform(emailValidator);
  Stream<FieldState> get outPassword =>
      _passwordController.stream.transform(passwordValidator);

  void dispose() {
    _stateController.close();
    _emailController.close();
    _passwordController.close();
  }
}
