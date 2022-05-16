import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:search_address/src/blocs/address/address_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const route = "/";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MaskTextInputFormatter formatter;
  late TextEditingController controller;
  late bool isValid;

  @override
  void initState() {
    super.initState();
    isValid = false;
    controller = TextEditingController(text: "");
    formatter = MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'\d')});
  }

  void onInputChanged(String text) {
    setState(() {
      isValid = formatter.unmaskText(text).length == 8;
    });
  }

  void onSubmit() {
    var zipCode = formatter.unmaskText(controller.text);
    context.read<AddressBloc>().add(AddressEventFetch(zipCode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('screen.main.app_bar.title')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [formatter],
              controller: controller,
              onChanged: onInputChanged,
              decoration: InputDecoration(
                labelText: translate('screen.main.field.zip_code.label'),
                hintText: translate('screen.main.field.zip_code.hint'),
              ),
            ),
          ),
          BlocBuilder<AddressBloc, AddressState>(
            builder: (context, state) {
              if (state is AddressStateLoading) {
                return const Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: isValid ? onSubmit : null,
                    child: Text(translate('screen.main.button.submit')),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
