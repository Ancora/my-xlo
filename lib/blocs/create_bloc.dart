import 'package:myxlo/models/ad.dart';
import 'package:rxdart/rxdart.dart';

enum CreateState { IDLE, LOADING, DONE }

class CreateBloc {
  final BehaviorSubject<CreateState> _stateController =
      BehaviorSubject<CreateState>.seeded(CreateState.IDLE);
  Stream<CreateState> get outState => _stateController.stream;

  Future<bool> saveAd(Ad ad) async {
    _stateController.add(CreateState.LOADING);
    // enviar o ad para o repositório

    await Future.delayed(Duration(seconds: 3));

    _stateController.add(CreateState.DONE);
    return true;
  }

  void dispose() {
    _stateController.close();
  }
}
