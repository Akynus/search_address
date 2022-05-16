import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search_address/src/blocs/address/address_bloc.dart';
import 'package:search_address/src/models/address.dart';
import 'package:search_address/src/models/coordinate.dart';
import 'package:search_address/src/models/location.dart';

import 'address_bloc.mocks.dart';

class MockAddressApi extends Mock implements AddressApi {}

@GenerateMocks([MockAddressApi])
void main() {
  group("Test Address' Bloc", () {
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

    group("Test State Data", () {
      var api = MockMockAddressApi();
      when(api.fetch("")).thenAnswer((_) async => address);

      blocTest<AddressBloc, AddressState>(
        "Check State",
        build: () => AddressBloc(api),
        act: (bloc) => bloc.add(AddressEventFetch("")),
        expect: () => [AddressStateLoading(), AddressStateData(address)],
      );
    });

    group("Test State Data", () {
      var api = MockMockAddressApi();

      blocTest<AddressBloc, AddressState>(
        "Check State",
        build: () => AddressBloc(api),
        act: (bloc) => bloc.add(AddressEventReset()),
        expect: () => [AddressStateEmpty()],
      );
    });

    group("Test State Dio Error", () {
      var api = MockMockAddressApi();
      when(api.fetch("")).thenThrow(DioError(requestOptions: RequestOptions(path: "")));

      blocTest<AddressBloc, AddressState>(
        "Check State",
        build: () => AddressBloc(api),
        act: (bloc) => bloc.add(AddressEventFetch("")),
        expect: () => [AddressStateLoading(), AddressStateError("")],
      );
    });

    group("Test State Generic Error", () {
      var api = MockMockAddressApi();
      when(api.fetch("")).thenThrow(Exception("Generic Error"));

      blocTest<AddressBloc, AddressState>(
        "Check State",
        build: () => AddressBloc(api),
        act: (bloc) => bloc.add(AddressEventFetch("")),
        expect: () => [AddressStateLoading(), AddressStateError("")],
      );
    });
  });
}
