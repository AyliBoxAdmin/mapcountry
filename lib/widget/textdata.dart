import 'package:flutter/material.dart';


class TextData extends StatelessWidget {

  late ThemeData _theme;
  late TextTheme _textTheme;
  late ColorScheme _colorScheme;

  String? beforeText;
  String? afterText;
  String? setText;

  TextData({
    Key? key,
    this.beforeText = "",
    this.afterText = "",
    this.setText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _textTheme = _theme.textTheme;
    _colorScheme = _theme.colorScheme;

    return RichText( //Text(widget.setText!);
      text: TextSpan(
        text: '${beforeText}',
        style: _textTheme.bodyText1!.copyWith(color: Colors.white70, fontSize: 12), //TextStyle(color: Colors.deepOrange),
        children: <TextSpan>[
          TextSpan(text: setText != null && setText != "null" ? setText : "no data", style: _textTheme.headline6!.copyWith(color: const Color(0xAFFFBB73)),), //TextStyle(color: Colors.deepOrange),
          TextSpan(text: afterText, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

}