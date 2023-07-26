import 'package:deutschvocab/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../colors.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    this.labelText,
    this.borderColor,
    this.focusedBorderColor,
    this.isPassword = false,
    this.textColor,
    this.validator,
    this.showPassword = false,
    this.keyboardType,
    this.width,
  });

  final TextEditingController controller;
  final String? labelText;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? textColor;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool showPassword;
  final TextInputType? keyboardType;
  final double? width;

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<LoginProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          TextFormField(
            keyboardType: keyboardType ?? TextInputType.text,
            controller: controller,
            decoration: InputDecoration(
              label: Text(
                labelText ?? '',
                style: TextStyle(color: textColor ?? darkYellow),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              focusColor: darkYellow,
              hoverColor: lightYellow,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: focusedBorderColor ?? lightYellow,
                    width: width ?? 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: focusedBorderColor ?? lightYellow,
                  width: width ?? 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: darkYellow, width: width ?? 1.0),
              ),
            ),
            cursorColor: lightYellow,
            validator: validator,
            obscureText: isPassword ? prov.showPassword : false,
          ),
          isPassword
              ? Positioned(
                  top: 0,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      prov.showPassword = !prov.showPassword;
                    },
                    icon: !prov.showPassword
                        ? Icon(
                            Icons.remove_red_eye,
                            color: borderColor ?? darkYellow,
                          )
                        : Icon(
                            Icons.remove_red_eye_outlined,
                            color: borderColor ?? darkYellow,
                          ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
