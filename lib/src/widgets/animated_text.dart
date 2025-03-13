import 'package:flutter/material.dart';
import 'package:flutter_gen_ai_chat_ui/src/providers/theme_provider.dart';
import 'package:flutter_gen_ai_chat_ui/src/utils/font_helper.dart';

class AnimatedTextMessage extends StatefulWidget {
  const AnimatedTextMessage({
    super.key,
    required this.text,
    this.style,
    this.animate = false,
    required this.isUser,
    this.isStreaming = false,
    this.textBuilder,
  });
  final String text;
  final TextStyle? style;
  final bool animate;
  final bool isUser;
  final bool isStreaming;
  final Widget Function(String text, TextStyle? style)? textBuilder;

  @override
  State<AnimatedTextMessage> createState() => _AnimatedTextMessageState();
}

class _AnimatedTextMessageState extends State<AnimatedTextMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(final AnimatedTextMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text && widget.animate) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomThemeExtension>() ??
        ThemeProvider.lightTheme.extension<CustomThemeExtension>()!;

    final textStyle = FontHelper.getAppropriateFont(
      text: widget.text,
      baseStyle: widget.style ??
          TextStyle(
            color: customTheme.messageTextColor,
            fontSize: 15,
            height: 1.4,
          ),
    );

    final isRtlText = FontHelper.isRTL(widget.text);
    final textAlign = isRtlText ? TextAlign.right : TextAlign.left;
    final textDirection = isRtlText ? TextDirection.rtl : TextDirection.ltr;

    Widget buildText(final String text, final TextStyle? style) {
      if (widget.textBuilder != null) {
        return widget.textBuilder!(text, style);
      }
      return Text(
        text,
        style: style,
        textAlign: textAlign,
        textDirection: textDirection,
      );
    }

    // Instead of using Directionality, use Container with alignment to respect text direction
    // while not affecting surrounding elements
    return Container(
      alignment: FontHelper.getAlignment(widget.text),
      width: double.infinity,
      child: widget.isStreaming
          ? StreamingText(
              text: widget.text,
              style: textStyle,
              textBuilder: widget.textBuilder,
            )
          : FadeTransition(
              opacity: _fadeAnimation,
              child: buildText(widget.text, textStyle),
            ),
    );
  }
}

class StreamingText extends StatefulWidget {
  const StreamingText({
    super.key,
    required this.text,
    this.style,
    this.textBuilder,
  });
  final String text;
  final TextStyle? style;
  final Widget Function(String text, TextStyle? style)? textBuilder;

  @override
  State<StreamingText> createState() => _StreamingTextState();
}

class _StreamingTextState extends State<StreamingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  String _previousText = '';

  @override
  void initState() {
    super.initState();
    _previousText = widget.text;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(final StreamingText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text) {
      _previousText = oldWidget.text;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (final context, final child) {
          final newText = widget.text.substring(_previousText.length);
          final isRtlText = FontHelper.isRTL(widget.text);
          final textAlign = FontHelper.getTextAlign(widget.text);
          final textDirection =
              isRtlText ? TextDirection.rtl : TextDirection.ltr;

          // Use a Column instead of Row to avoid directional issues
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: FontHelper.getCrossAxisAlignment(widget.text),
            children: [
              if (_previousText.isNotEmpty)
                Container(
                  alignment: FontHelper.getAlignment(widget.text),
                  width: double.infinity,
                  child: buildText(
                      _previousText, widget.style, textAlign, textDirection),
                ),
              if (newText.isNotEmpty)
                Container(
                  alignment: FontHelper.getAlignment(widget.text),
                  width: double.infinity,
                  child: buildText(
                    newText,
                    widget.style?.copyWith(
                      color: widget.style?.color
                          ?.withAlpha((_fadeAnimation.value * 255).toInt()),
                    ),
                    textAlign,
                    textDirection,
                  ),
                ),
            ],
          );
        },
      );

  Widget buildText(final String text, final TextStyle? style,
      final TextAlign textAlign, final TextDirection textDirection) {
    if (widget.textBuilder != null) {
      return widget.textBuilder!(text, style);
    }
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}
