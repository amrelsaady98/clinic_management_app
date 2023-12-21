import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required TextEditingController controller,
      String? lable,
      List<TextInputFormatter>? inputFormatter})
      : _inputFormatter = inputFormatter,
        _lable = lable,
        _controller = controller;

  final TextEditingController _controller;
  final String? _lable;
  final List<TextInputFormatter>? _inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) {},
      inputFormatters: _inputFormatter,
      decoration: InputDecoration(
        label: _lable != null ? Text(_lable) : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.mm))),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 2.mm),
      ),
    );
  }
}
