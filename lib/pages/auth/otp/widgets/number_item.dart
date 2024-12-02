import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberItem extends StatelessWidget {
  final FocusNode? focusNode;
  final ValueChanged<String> onChanged;

  const NumberItem({super.key, this.focusNode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 48,
      child: TextField(
        focusNode: focusNode,
        style: Theme.of(context).textTheme.headlineSmall,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onChanged: (val) {
          onChanged(val);
          if (val.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
