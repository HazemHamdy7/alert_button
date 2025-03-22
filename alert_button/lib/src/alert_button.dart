import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlertButton extends StatefulWidget {
  /// الحجم الكلي للزر (العرض والارتفاع)
  final double size;

  /// قائمة الألوان المستخدمة في تدرج لون الموجات
  final List<Color> waveColors;

  /// عدد الموجات (الأنيميشن)
  final int waveCount;

  /// مدة أنيميشن الموجة
  final Duration waveDuration;

  /// مدة أنيميشن الضغط
  final Duration pressDuration;

  /// مدة استمرار الأنيميشن بعد الضغط
  final Duration activeDuration;

  /// نص التسمية الرئيسي
  final String label;

  /// نص التسمية الفرعي
  final String subLabel;

  /// نمط النص الرئيسي
  final TextStyle? labelTextStyle;

  /// نمط النص الفرعي
  final TextStyle? subLabelTextStyle;

  const AlertButton({
    Key? key,
    this.size = 200,
    this.waveColors = const [Colors.red, Colors.orange],
    this.waveCount = 3,
    this.waveDuration = const Duration(seconds: 3),
    this.pressDuration = const Duration(milliseconds: 200),
    this.activeDuration = const Duration(seconds: 2), // مدة الأنيميشن بعد الضغط
    this.label = 'SOS',
    this.subLabel = 'Press for a while',
    this.labelTextStyle,
    this.subLabelTextStyle,
  }) : super(key: key);

  @override
  State<AlertButton> createState() => _AlertButtonState();
}

class _AlertButtonState extends State<AlertButton>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _pressController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: widget.waveDuration,
      vsync: this,
    );

    _pressController = AnimationController(
      duration: widget.pressDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  void _onLongPressStart() {
    setState(() => _isPressed = true);
    _pressController.forward();
    HapticFeedback.heavyImpact();

    // بدء أنيميشن الموجات
    _waveController.forward();

    // استمرار الأنيميشن لمدة activeDuration المحددة
    Future.delayed(widget.activeDuration, () {
      if (mounted) {
        setState(() => _isPressed = false);
        _pressController.reverse();
        _waveController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // تكرار الموجات بحسب القيمة [waveCount]
          ...List.generate(widget.waveCount, (index) {
            return AnimatedBuilder(
              animation: _waveController,
              builder: (context, child) {
                final double delay = index * 0.3;
                final double progress = (_waveController.value + delay) % 1.0;
                return Opacity(
                  opacity: math.max(0, 1 - progress),
                  child: Transform.scale(
                    scale: 0.7 + (progress * 0.8),
                    child: Container(
                      width: widget.size * 0.85,
                      height: widget.size * 0.85,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: widget.waveColors),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.waveColors.first.withOpacity(0.5),
                          width: widget.size * 0.25,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
          // زر التنبيه
          GestureDetector(
            onLongPress: _onLongPressStart,
            child: AnimatedBuilder(
              animation: _pressController,
              builder: (context, child) {
                final scale = 1.0 - (_pressController.value * 0.05);
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: widget.size * 0.8,
                    height: widget.size * 0.8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white10,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: widget.size * 0.1,
                          blurRadius: widget.size * 0.4,
                          offset: const Offset(10, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: widget.size * 0.65,
                        height: widget.size * 0.65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: _isPressed
                                ? widget.waveColors
                                : widget.waveColors.reversed.toList(),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.label,
                              style: widget.labelTextStyle ??
                                  TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              widget.subLabel,
                              style: widget.subLabelTextStyle ??
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
