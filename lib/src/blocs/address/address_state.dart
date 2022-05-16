import 'package:equatable/equatable.dart';
import 'package:search_address/src/models/address.dart';

abstract class AddressState extends Equatable {}

class AddressStateEmpty extends AddressState{
  @override
  List<Object?> get props => [];
}

class AddressStateLoading extends AddressState {
  @override
  List<Object?> get props => [];
}

class AddressStateError extends AddressState {
  final String zipCode;

  AddressStateError(this.zipCode);

  @override
  List<Object?> get props => [zipCode];
}

class AddressStateData extends AddressState {
  final Address data;

  AddressStateData(this.data);

  @override
  List<Object?> get props => [data];
}
