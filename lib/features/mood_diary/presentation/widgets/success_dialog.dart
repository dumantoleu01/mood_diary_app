import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SuccessDialog extends StatelessWidget {
  final VoidCallback onClose;

  const SuccessDialog({
    super.key,
    required this.onClose,
  });

  static Future<void> show(BuildContext context, {required VoidCallback onClose}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SuccessDialog(onClose: onClose),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Запись сохранена!',
              style: AppTextStyles.heading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Ваша запись успешно добавлена в дневник настроения.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.hintTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onClose();
                },
                child: const Text('Отлично!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
