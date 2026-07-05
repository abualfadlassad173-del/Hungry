import 'package:flutter/material.dart';
import 'package:hungry/core/theme/app_colors.dart';

class SpicySliderView extends StatefulWidget {
  const SpicySliderView({super.key, required this.spicyLevel, required this.onChanged});
  final double spicyLevel;
  final ValueChanged<double> onChanged;

  @override
  State<SpicySliderView> createState() => _SpicySliderViewState();
}

class _SpicySliderViewState extends State<SpicySliderView> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 5,
        activeTrackColor: Appcolors.background,
        inactiveTrackColor: Appcolors.background.withValues(alpha: 0.14),
        thumbColor: Appcolors.white,
        overlayColor: Appcolors.background.withValues(alpha: 0.12),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
      ),
      child: Slider(
        min: 0,
        max: 1,
        value: widget.spicyLevel,
        onChanged: widget.onChanged,
      ),
    );
  }
}
