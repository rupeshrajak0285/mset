

import '../../common_libraries.dart';

class AspirantCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final List<TextSpan> textSpans;

  const AspirantCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.textSpans,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black, fontSize: 14),
              children: textSpans,
            ),
          ),
        ),
      ],
    );
  }
}
