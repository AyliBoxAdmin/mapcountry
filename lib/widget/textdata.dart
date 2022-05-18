import 'package:flutter/material.dart';


class TextData extends StatelessWidget {
  const TextData({
    Key? key,
    this.beforeText = "",
    this.afterText = "",
    this.setText = "",
  }) : super(key: key);

  final String? beforeText;
  final String? afterText;
  final String? setText;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    TextTheme _textTheme = _theme.textTheme;
    ColorScheme _colorScheme = _theme.colorScheme;

    return RichText( //Text(widget.setText!);
      text: TextSpan(
        style: _textTheme.bodyText2!.copyWith(color: _colorScheme.tertiary),
        text: beforeText,
        children: <TextSpan>[
          TextSpan(text: setText != null && setText != "null" ? setText : "no data",
            style: _textTheme.bodyText1!.copyWith(color: setText != null && setText != "null" ? _colorScheme.primary : _colorScheme.error),
          ),
          TextSpan(text: afterText),
        ],
      ),
    );
  }

}