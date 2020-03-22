import 'package:dio/dio.dart';
import 'package:myxlo/models/address.dart';
import 'package:myxlo/repositories/api_error.dart';
import 'package:myxlo/repositories/api_response.dart';

Future<ApiResponse> getAddressFromAPI(String postalCode) async {
  final String endpoint =
      'http://viacep.com.br/ws/${postalCode.replaceAll('.', '').replaceAll('-', '')}/json/';

  try {
    final Response response = await Dio().get<Map>(endpoint);

    if (response.data.containsKey('erro') && response.data['erro']) {
      return ApiResponse.error(
        error: ApiError(
          code: -1,
          message: 'CEP inválido!',
        ),
      );
    }
    final Address address = Address(
      place: response.data['logradouro'],
      //number: response.data['número'],
      //complement: response.data['complemento'],
      district: response.data['bairro'],
      city: response.data['localidade'],
      postalCode: response.data['cep'],
      federativeUnit: response.data['uf'],
    );
    print(address);
    //return ApiResponse.success(result: address);
  } on DioError catch (e) {
    return ApiResponse.error(
      error: ApiError(
        code: -1,
        message: 'Falha ao conectar VIACEP!',
      ),
    );
  }
}
