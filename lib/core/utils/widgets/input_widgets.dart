import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    TextEditingController? controller,
    String? lable,
    List<TextInputFormatter>? inputFormatter,
    void Function(String value)? onChange,
  })  : _inputFormatter = inputFormatter,
        _lable = lable,
        _controller = controller,
        _onChange = onChange;

  final TextEditingController? _controller;
  final String? _lable;
  final List<TextInputFormatter>? _inputFormatter;
  final void Function(String value)? _onChange;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChange,
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
