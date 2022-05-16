import 'package:flutter/material.dart';

class InfoLabel extends StatelessWidget {
  final String label;
  final String text;

  const InfoLabel({
    Key? key,
    required this.text,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      style: ListTileStyle.drawer,
      title: Text(label, style: theme.textTheme.caption),
      subtitle: Text(text, style: theme.textTheme.bodyText1),
    );
  }
}
