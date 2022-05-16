import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:search_address/src/blocs/address/address_event.dart';
import 'package:search_address/src/blocs/address/address_state.dart';
import 'package:search_address/src/models/address.dart';

export 'package:search_address/src/blocs/address/address_event.dart';
export 'package:search_address/src/blocs/address/address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressApi api;

  AddressBloc(this.api) : super(AddressStateEmpty()) {
    on<AddressEventFetch>(_fetch);
    on<AddressEventReset>(_reset);
  }

  void _reset(AddressEventReset event, Emitter<AddressState> emit) {
    emit(AddressStateEmpty());
  }

  void _fetch(AddressEventFetch event, Emitter<AddressState> emit) async {
    emit(AddressStateLoading());

    try {
      var data = await api.fetch(event.zip);
      emit(AddressStateData(data));
    } on DioError catch (_) {
      emit(AddressStateError(event.zip));
    } catch (_) {
      emit(AddressStateError(event.zip));
    }
  }
}
