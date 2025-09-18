import '../../common_libraries.dart';

class AspirantCardImageWidget extends StatelessWidget {
  final String imagePath;
  final double height;

  const AspirantCardImageWidget({
    super.key,
    required this.imagePath,
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
