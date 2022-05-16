abstract class AddressEvent {}

class AddressEventReset extends AddressEvent {}

class AddressEventFetch extends AddressEvent {
  final String zip;
  AddressEventFetch(this.zip);
}
