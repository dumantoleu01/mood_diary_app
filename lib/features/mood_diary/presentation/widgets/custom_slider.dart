import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CustomSlider extends StatelessWidget {
  final String title;
  final String leftLabel;
  final String rightLabel;
  final int value;
  final ValueChanged<int> onChanged;

  const CustomSlider({
    super.key,
    required this.title,
    required this.leftLabel,
    required this.rightLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.heading),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(color: Color(0x1CB6A1C0), blurRadius: 10, offset: Offset(2, 4)),
            ],
          ),
          child: Column(
            children: [
              _buildTickMarks(),
              const SizedBox(height: 4),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: _CustomThumbShape(),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                  activeTrackColor: AppColors.activeTab,
                  inactiveTrackColor: AppColors.sliderInactive,
                  thumbColor: AppColors.white,
                  overlayColor: AppColors.activeTab.withValues(alpha: 0.2),
                  trackShape: const RoundedRectSliderTrackShape(),
                ),
                child: Slider(
                  value: value.toDouble(),
                  min: 0,
                  max: 100,
                  onChanged: (val) => onChanged(val.toInt()),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(leftLabel, style: AppTextStyles.sliderLabel),
                    Text(rightLabel, style: AppTextStyles.sliderLabel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTickMarks() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          6,
          (index) => Container(
            width: 2,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.sliderInactive,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(20, 20);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(center + const Offset(0, 2), 10, shadowPaint);

    final fillPaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 10, fillPaint);

    final borderPaint = Paint()
      ..color = AppColors.activeTab
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, 9, borderPaint);
  }
}
