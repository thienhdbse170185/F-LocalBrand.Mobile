import 'package:flutter/material.dart';

class OtpField extends StatefulWidget {
  final int length;
  final Function(String) onChanged;

  OtpField({Key? key, required this.length, required this.onChanged})
      : super(key: key);

  @override
  _OtpFieldState createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  List<TextEditingController> _controllers = [];
  String _otp = '';

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _controllers = List.generate(
      widget.length,
      (_) => TextEditingController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            width: 48,
            child: TextField(
              controller: _controllers[index],
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _otp = _otp.replaceRange(index, index + 1, value);
                  if (index < widget.length - 1) {
                    FocusScope.of(context).nextFocus();
                  }
                  widget.onChanged(_otp);
                } else {
                  _otp = _otp.replaceRange(index, index + 1, '');
                  if (index > 0) {
                    FocusScope.of(context).previousFocus();
                  }
                  widget.onChanged(_otp);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
