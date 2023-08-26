import '../../../../common/config/theme/theme_export.dart';
import '../../../../common/utils/widgets/button.dart';

class UploadWidget extends StatelessWidget {
  const UploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Button(onPressed: () {}, child: const Text('Upload'))],
    );
  }
}
