import 'package:flutter/material.dart';
import 'package:formify/constants/export.dart';

class MyTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool? isObSecure;
  final bool? haveLabel;
  final bool? isReadOnly;
  final double? marginBottom;
  final double? radius;
  final int? maxLines;
  final double? labelSize;
  final double? hintsize;
  final FocusNode? focusNode;
  final Color? filledColor;
  final Color? focusedFillColor;
  bool? autoFocus;
  final Color? bordercolor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? focusBorderColor;
  final Widget? prefix;
  final Widget? suffix;
  final FontWeight? labelWeight;
  final FontWeight? hintWeight;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final double? height;
  final double? width;
  final String? Function(String?)? validator;
  final bool? showPasswordToggle;

  MyTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.onChanged,
    this.isObSecure = false,
    this.marginBottom = 18.0,
    this.maxLines = 1,
    this.filledColor,
    this.focusedFillColor,
    this.hintColor,
    this.labelColor,
    this.haveLabel = true,
    this.labelSize,
    this.hintsize,
    this.prefix,
    this.suffix,
    this.autoFocus,
    this.labelWeight,
    this.hintWeight,
    this.keyboardType,
    this.isReadOnly,
    this.onTap,
    this.bordercolor,
    this.focusBorderColor,
    this.focusNode,
    this.radius,
    this.height = 58,
    this.width,
    this.validator,
    this.showPasswordToggle = false,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isFocused = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = widget.focusNode?.hasFocus ?? false;
    });
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  Widget _buildPasswordToggle() {
    return IconButton(
      icon: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
        size: 20,
      ),
      onPressed: () {
        setState(() {
          _isPasswordVisible = !_isPasswordVisible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.marginBottom ?? 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null && _isFocused)
            MyText(
              text: widget.label ?? '',
              size: widget.labelSize ?? 10,
              paddingBottom: 8,
              color: kDynamicText,
              fontFamily: AppFonts.Figtree,
              weight: widget.labelWeight ?? FontWeight.w500,
            ),
          Container(
            width: widget.width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius ?? 8),
              color: widget.focusedFillColor,
            ),
            child: TextFormField(
              focusNode: widget.focusNode,
              onTap: widget.onTap,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: widget.keyboardType,
              cursorColor: kPrimaryColor,
              maxLines: widget.maxLines ?? 1,
              readOnly: widget.isReadOnly ?? false,
              controller: widget.controller,
              autofocus: widget.autoFocus ?? false,
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              onChanged: widget.onChanged,
              obscureText: (widget.isObSecure ?? false) && !_isPasswordVisible,
              obscuringCharacter: '*',
              validator: widget.validator,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.Figtree,
                decoration: TextDecoration.none,
                color: kBlack,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: _isFocused 
                  ? widget.focusedFillColor ?? Colors.grey[100]
                  : widget.filledColor ?? Colors.grey[100],
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 8),
                  borderSide: BorderSide(
                    color: widget.focusBorderColor ?? kPrimaryColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 8),
                  borderSide: BorderSide(
                    color: _isFocused
                        ? widget.focusBorderColor ?? kPrimaryColor
                        : widget.bordercolor ?? Colors.transparent,
                    width: 1,
                  ),
                ),
                prefixIcon: widget.prefix,
                prefixIconConstraints: const BoxConstraints.tightFor(),
                suffixIconConstraints: const BoxConstraints.tightFor(),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: widget.showPasswordToggle == true 
                      ? _buildPasswordToggle() 
                      : widget.suffix,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: (widget.maxLines ?? 1) > 1 ? 15 : 0,
                ),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: widget.hintsize ?? 14,
                  fontFamily: AppFonts.Figtree,
                  color: widget.hintColor ?? kSubText,
                  fontWeight: widget.hintWeight ?? FontWeight.w400,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 8),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 8),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}