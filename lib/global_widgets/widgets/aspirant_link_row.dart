import '../../common_libraries.dart';

class AspirantLinkRow extends StatelessWidget {
  final String leftText;
  final String rightText;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const AspirantLinkRow({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.onLeftTap,
    required this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onLeftTap,
          child: Text(
            leftText,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        GestureDetector(
          onTap: onRightTap,
          child: Text(
            rightText,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
