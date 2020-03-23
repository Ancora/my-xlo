import 'package:myxlo/api/api_postalcode.dart';
import 'package:myxlo/models/address.dart';
import 'package:myxlo/repositories/api_response.dart';
import 'package:rxdart/rxdart.dart';

enum CepFieldState { INITIALIZING, INCOMPLETE, INVALID, VALID }

class CepBlocState {
  CepFieldState cepFieldState;
  String cep;
  Address address;

  CepBlocState({this.cepFieldState, this.cep, this.address});
}

class CepBloc {
  final BehaviorSubject<CepBlocState> _cepController =
      BehaviorSubject<CepBlocState>();

  void searchCep(String cep) async {
    final ApiResponse apiResponse = await getAddressFromAPI(cep);

    if (apiResponse.success) {
      _cepController.add(
        CepBlocState(
          cepFieldState: CepFieldState.VALID,
          cep: cep,
          address: apiResponse.result,
        ),
      );
    } else {
      _cepController.add(
        CepBlocState(
          cepFieldState: CepFieldState.INVALID,
          cep: cep,
        ),
      );
    }
  }

  void onChanged(String cep) {
    cep = cep.trim().replaceAll('-', '').replaceAll('.', '');

    if (cep.isEmpty || cep.length < 8) {
      _cepController.add(
        CepBlocState(
          cepFieldState: CepFieldState.INCOMPLETE,
          cep: cep,
        ),
      );
    } else {
      searchCep(cep);
    }
  }

  void dispose() {
    _cepController.close();
  }
}