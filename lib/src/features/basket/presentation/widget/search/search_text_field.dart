part of 'app_search_bar.dart';

class _SearchTextField extends StatefulWidget {
  const _SearchTextField({
    this.onChanged,
  });

  final ValueChanged<String>? onChanged;

  @override
  State<_SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<_SearchTextField> {
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
    return TextFormField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIconConstraints: const BoxConstraints.tightFor(
          height: 24,
          width: 34,
        ),
        prefixIcon: SvgPicture.asset(
          AppAssets.searchSvgIcon,
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
    );
  }
}
