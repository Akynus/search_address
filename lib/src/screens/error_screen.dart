import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:search_address/src/blocs/address/address_bloc.dart';

class ErrorScreen extends StatefulWidget {
  final String zipCode;

  const ErrorScreen({
    Key? key,
    required this.zipCode,
  }) : super(key: key);

  static const route = "/error";

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  late MaskTextInputFormatter formatter;

  @override
  void initState() {
    super.initState();
    formatter = MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'\d')});
  }

  void goBack() async{
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/images/404.png",
                fit: BoxFit.fitWidth,
                height: 150,
              ),
              const SizedBox(height: 50),
              FittedBox(
                child: Text(
                  translate("screen.error.message.description", args: {"text": formatter.maskText(widget.zipCode)}),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText1!.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300,
                height: 35,
                child: ElevatedButton(
                  onPressed: goBack,
                  child: Text(translate('screen.error.button.try_again')),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
