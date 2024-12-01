import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final Function(String?)? onChanged;
  const SearchTextField(
      {super.key,
      required this.hintText,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.onClear,  this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,

        fillColor: const Color(0xFFF2F2F6),
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon:
            IconButton(onPressed: onClear, icon: const Icon(Icons.close)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFFEFEFEF))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFFEFEFEF))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xFFEFEFEF))),
      ),
    );
  }
}
