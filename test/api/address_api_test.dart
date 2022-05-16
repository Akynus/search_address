import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:search_address/src/models/address.dart';
import 'package:search_address/src/models/coordinate.dart';
import 'package:search_address/src/models/location.dart';

void main() {
  group("Test Address' API", () {
    late Dio dio;
    late DioAdapter adapter;
    late AddressApi api;

    setUp(() {
      dio = Dio(BaseOptions());
      adapter = DioAdapter(dio: dio);
      api = AddressApi(dio);
    });

    group("Fetch data", () {
      final coordinates = Coordinate();
      final location = Location(type: "", coordinates: coordinates);
      final address = Address(
        cep: "00000000",
        city: "",
        service: "",
        state: "",
        neighborhood: "",
        street: "",
        location: location,
      );

      test("When request is 200", () async {
        const url = "https://brasilapi.com.br/api/cep/v2/00000000";
        adapter.onGet(url, (server) => server.reply(200, address.toJson()));

        var data = await api.fetch("00000000");
        expect(data.toJson().toString(), address.toJson().toString());
      });

      test("When request is 404", () async {
        const url = "https://brasilapi.com.br/api/cep/v2/00000000";
        adapter.onGet(url, (server) => server.reply(404, address.toJson()));

        expect(() => api.fetch("00000000"), throwsA(isInstanceOf<DioError>()));
      });
    });
  });
}
