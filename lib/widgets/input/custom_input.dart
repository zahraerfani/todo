import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:todo/config/themes/my_drawing.dart';

class CustomInput extends StatefulWidget {
  final IconData? preIcon;
  final Color? preIconColor;
  final Color? borderColor;
  final Color? disableBorderColor;
  final IconData? sufIcon;
  final String? labelText;
  final Color? labelTextColor;
  final String? hintText;
  final Color? hintTextColor;
  final bool? obscure;
  final bool? enable;
  final bool? price;
  final Function()? sufIconTap;
  final Function(String) enterData;
  final String? validation;
  final String? Function(String? data)? validator;
  final int? maxLength;
  final int? maxLine;
  final TextInputType? type;
  final String? initialText;

  const CustomInput(
      {Key? key,
      this.preIcon,
      this.preIconColor,
      this.borderColor,
      this.disableBorderColor,
      this.labelText,
      this.labelTextColor,
      this.hintTextColor,
      this.hintText,
      this.obscure,
      this.enable,
      this.price,
      this.sufIcon,
      this.sufIconTap,
      this.maxLength,
      this.maxLine,
      required this.enterData,
      this.validation,
      this.type,
      this.initialText,
      this.validator})
      : super(key: key);

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  Random random = Random();
  int randomNumber = 0;

  FieldValidator<String?> selectValidator() {
    if (widget.enable == false) {
      return noValidator;
    } else {
      switch (widget.validation) {
        case "minLength":
          return minLengthValidator;
        case "required":
          return requiredValidator;
        case "email":
          return emailValidator;
        // case "mobile":
        //   return mobileValidator;
        default:
          return noValidator;
      }
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    setState(() {
      randomNumber = random.nextInt(50);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return TextFormField(
      enabled: widget.enable,
      inputFormatters: widget.price == true
          ? [
              LengthLimitingTextInputFormatter(widget.maxLength),
              FilteringTextInputFormatter.digitsOnly,
              // ThousandsFormatter(),
            ]
          : [
              LengthLimitingTextInputFormatter(widget.maxLength),
            ],
      key: Key(randomNumber.toString()),
      initialValue: widget.initialText,
      maxLines: widget.maxLine,
      obscureText: widget.obscure ?? false,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: widget.type ?? TextInputType.text,
      decoration: InputDecoration(
          errorStyle: textTheme.bodyText1?.copyWith(
              color:
                  widget.enable == false ? Colors.transparent : MyColors.red),
          contentPadding: const EdgeInsets.only(
              right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
                width: 1, color: widget.borderColor ?? MyColors.primaryDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
                width: 1, color: widget.borderColor ?? MyColors.primaryDark),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
                width: 1,
                color: (widget.enable == false
                        ? widget.disableBorderColor
                        : widget.borderColor) ??
                    MyColors.primaryDark),
          ),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
                width: 1, color: widget.borderColor ?? MyColors.primaryDark),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                width: 1,
                color: widget.enable == false
                    ? widget.disableBorderColor ?? MyColors.primaryDark
                    : MyColors.primaryDark,
              )),
          prefixIcon: widget.preIcon != null
              ? Icon(
                  widget.preIcon,
                  color: widget.preIconColor ?? MyColors.grey_40,
                  size: 20,
                )
              : null,
          suffixIcon: widget.sufIcon != null
              ? IconButton(
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    widget.sufIconTap!();
                  },
                  icon: Icon(
                    widget.sufIcon,
                    color: MyColors.grey_40,
                    size: 24,
                  ))
              : null,
          labelText: widget.labelText ?? "",
          labelStyle: textTheme.caption
              ?.copyWith(color: widget.labelTextColor ?? MyColors.grey_40),
          hintText: widget.hintText ?? '',
          hintStyle: textTheme.caption
              ?.copyWith(color: widget.labelTextColor ?? MyColors.grey_40)),
      style: widget.enable == false
          ? textTheme.bodyText1?.copyWith(color: widget.disableBorderColor)
          : textTheme.bodyText1,
      validator: selectValidator(),
      onChanged: (text) {
        widget.enterData(text);
      },
    );
  }

  final requiredValidator =
      RequiredValidator(errorText: 'this field is required');
  final minLengthValidator = MinLengthValidator(6,
      errorText: 'password must be at least 6 digits long');
  final dateValidator = MultiValidator([
    RequiredValidator(errorText: 'enter a valid date'),
    PatternValidator(r'(\d{2}-(0[1-9]|1[0-2]))',
        errorText: 'enter a valid date')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'enter a valid email'),
    PatternValidator(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
        errorText: 'enter a valid email')
  ]);
  final noValidator = MultiValidator([NoValidate(errorText: "")]);
}

class NoValidate extends TextFieldValidator {
  @override
  bool get ignoreEmptyValues => false;

  NoValidate({required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    return true;
  }
}
