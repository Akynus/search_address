import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_address/src/blocs/address/address_bloc.dart';
import 'package:search_address/src/screens/error_screen.dart';
import 'package:search_address/src/screens/info_screen.dart';
import 'package:search_address/src/screens/main_screen.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            const MaterialPage(child: MainScreen()),
            if (state is AddressStateData) MaterialPage(child: InfoScreen(data: state.data)),
            if (state is AddressStateError) MaterialPage(child: ErrorScreen(zipCode: state.zipCode)),
          ],
          onPopPage: (route, result) {
            BlocProvider.of<AddressBloc>(context).add(AddressEventReset());
            return route.didPop(result);
          },
        );
      },
    );
  }
}
