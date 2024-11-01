import 'package:flutter/material.dart';
import 'package:product_basket/src/common/widget/app_chip.dart';

class ChipMultiSelector<T> extends StatefulWidget {
  const ChipMultiSelector._({
    required this.title,
    required this.possibleValues,
    required this.toText,
    this.selectedValues,
    super.key,
  });

  final String title;
  final List<T> possibleValues;
  final String Function(T value) toText;
  final List<T>? selectedValues;

  static Future<List<T>?> show<T>({
    required BuildContext context,
    required String title,
    required List<T> possibleValues,
    required String Function(T value) toText,
    List<T>? selectedValues,
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
          child: ChipMultiSelector._(
            possibleValues: possibleValues,
            title: title,
            toText: toText,
            selectedValues: selectedValues,
          ),
        ),
      ),
    );
  }

  @override
  State<ChipMultiSelector<T>> createState() => _ChipMultiSelectorState<T>();
}

class _ChipMultiSelectorState<T> extends State<ChipMultiSelector<T>> {
  late final List<T> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues =
        widget.selectedValues == null ? [] : [...widget.selectedValues!];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            children: widget.possibleValues.map((value) {
              final isSelected = selectedValues.contains(value);

              return AppChip(
                isSelected: isSelected,
                text: widget.toText(value),
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
