import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class FormattedMessage extends StatelessWidget {
  const FormattedMessage({
    super.key,
    required this.message,
    required this.isUser,
  });

  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    if (isUser) {
      return SelectableText(
        message,
        style: const TextStyle(height: 1.6, fontSize: 15),
      );
    }

    final segments = _splitMessage(message);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final segment in segments)
          Padding(
            padding: EdgeInsets.only(
              bottom: segment == segments.last ? 0 : 10,
            ),
            child: segment.isMath
                ? _MathSegment(source: segment.text, isDisplay: segment.isDisplay)
                : _MarkdownSegment(source: segment.text),
          ),
      ],
    );
  }

  List<_MessageSegment> _splitMessage(String source) {
    final pattern = RegExp(
      r'(\$\$[\s\S]*?\$\$|\$[^$\n]+\$)',
      multiLine: true,
    );
    final segments = <_MessageSegment>[];
    var cursor = 0;

    for (final match in pattern.allMatches(source)) {
      if (match.start > cursor) {
        segments.add(_MessageSegment.markdown(source.substring(cursor, match.start)));
      }

      final raw = match.group(0)!;
      final isDisplay = raw.startsWith(r'$$');
      final text = isDisplay
          ? raw.substring(2, raw.length - 2)
          : raw.substring(1, raw.length - 1);

      segments.add(_MessageSegment.math(text.trim(), isDisplay: isDisplay));
      cursor = match.end;
    }

    if (cursor < source.length) {
      segments.add(_MessageSegment.markdown(source.substring(cursor)));
    }

    return segments.where((segment) => segment.text.trim().isNotEmpty).toList();
  }
}

class _MarkdownSegment extends StatelessWidget {
  const _MarkdownSegment({required this.source});

  final String source;

  @override
  Widget build(BuildContext context) {
    final baseStyle = DefaultTextStyle.of(context).style;

    return MarkdownBody(
      data: source.trim(),
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: baseStyle.copyWith(fontSize: 15, height: 1.6),
        strong: baseStyle.copyWith(fontWeight: FontWeight.w800),
        h1: baseStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w800),
        h2: baseStyle.copyWith(fontSize: 19, fontWeight: FontWeight.w800),
        h3: baseStyle.copyWith(fontSize: 17, fontWeight: FontWeight.w800),
        listBullet: baseStyle.copyWith(fontSize: 15, height: 1.6),
        blockquote: baseStyle.copyWith(
          color: const Color(0xff475569),
          fontSize: 15,
          height: 1.6,
        ),
        code: baseStyle.copyWith(
          backgroundColor: const Color(0xffEEF2F7),
          color: const Color(0xff0F172A),
          fontSize: 14,
        ),
        codeblockDecoration: BoxDecoration(
          color: const Color(0xffEEF2F7),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _MathSegment extends StatelessWidget {
  const _MathSegment({required this.source, required this.isDisplay});

  final String source;
  final bool isDisplay;

  @override
  Widget build(BuildContext context) {
    final math = Math.tex(
      source,
      textStyle: TextStyle(
        fontSize: isDisplay ? 18 : 15,
        color: const Color(0xff0F172A),
      ),
      mathStyle: isDisplay ? MathStyle.display : MathStyle.text,
      onErrorFallback: (error) {
        return SelectableText(
          isDisplay ? r'$$' '$source' r'$$' : r'$' '$source' r'$',
          style: const TextStyle(height: 1.6, fontSize: 15),
        );
      },
    );

    if (!isDisplay) {
      return math;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: math,
      ),
    );
  }
}

class _MessageSegment {
  const _MessageSegment._({
    required this.text,
    required this.isMath,
    required this.isDisplay,
  });

  factory _MessageSegment.markdown(String text) {
    return _MessageSegment._(text: text, isMath: false, isDisplay: false);
  }

  factory _MessageSegment.math(String text, {required bool isDisplay}) {
    return _MessageSegment._(text: text, isMath: true, isDisplay: isDisplay);
  }

  final String text;
  final bool isMath;
  final bool isDisplay;
}
