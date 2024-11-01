import 'package:flutter/material.dart';

class FilterModal<T> extends StatefulWidget {
  const FilterModal._({
    required this.values,
    required this.title,
    required this.valueToString,
    required this.initialSelection,
    super.key,
  });

  final List<T> values;
  final String title;
  final String Function(T value) valueToString;
  final List<T> initialSelection;

  static Future<List<T>?> show<T>({
    required BuildContext context,
    required List<T> values,
    required String title,
    required String Function(T value) valueToString,
    List<T> initialSelection = const [],
  }) {
    return showModalBottomSheet<List<T>>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: FilterModal._(
            values: values,
            title: title,
            valueToString: valueToString,
            initialSelection: initialSelection,
          ),
        ),
      ),
    );
  }

  @override
  State<FilterModal<T>> createState() => _FilterModalState<T>();
}

class _FilterModalState<T> extends State<FilterModal<T>> {
  late final List<T> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = [...widget.initialSelection];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.values.map((value) {
              final isSelected = selectedValues.contains(value);
              return _Chip(
                isSelected: isSelected,
                text: widget.valueToString(value),
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      selectedValues.remove(value);
                    } else {
                      selectedValues.add(value);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, <T>[]);
                },
                child: const Text('Reset'),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context, selectedValues);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.isSelected,
    required this.text,
    required this.onTap,
  });

  final bool isSelected;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
