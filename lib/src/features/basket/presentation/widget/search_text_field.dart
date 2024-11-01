import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_basket/src/common/constants/app_assets.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    this.onChanged,
    this.onTap,
    this.requestFocus = false,
    super.key,
  });

  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool requestFocus;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: TextFormField(
        controller: _controller,
        enabled: widget.onTap == null,
        onChanged: widget.onChanged,
        autofocus: widget.requestFocus,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints.tightFor(
            height: 24,
            width: 34,
          ),
          prefixIcon: SvgPicture.asset(
            AppAssets.searchIcon,
            colorFilter: const ColorFilter.mode(
              Color(0xFF86869E),
              BlendMode.srcIn,
            ),
          ),
          filled: true,
          fillColor: const Color(0xFFF3F4F9),
          isDense: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: 'Search for fruit salad combos',
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color(0xFF86869E),
          ),
        ),
      ),
    );
  }
}
