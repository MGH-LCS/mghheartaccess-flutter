import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

// Link pattern
final RegExp linkRegExp = RegExp(
  r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?',
);
// Email pattern
final RegExp emailRegExp = RegExp(
  r'[\w.%+-]+@[\w.-]+\.[\w]{2,4}',
);
// Phone pattern
final RegExp phoneRegExp = RegExp(
  r'[\d-]{9,}',
);
// Combined pattern for all three
final RegExp combinedRegExp = RegExp(
  r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?|' // Link pattern
  r'[\w.%+-]+@[\w.-]+\.[\w]{2,4}|' // Email pattern
  r'[\d-]{9,}', // Phone pattern
);

class RecognizableTextWidget extends StatelessWidget {
  const RecognizableTextWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(
          ClipboardData(text: text),
        );
      },
      child: SelectableText.rich(
        TextSpan(
          children: _buildTextSpans(text),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String text) {
    final List<TextSpan> textSpans = [];
    text.splitMapJoin(
      combinedRegExp,
      onMatch: (Match match) {
        // if text part is matched with our pattern
        // this method is ommited and add new TextSpan to the list.
        textSpans.add(
          TextSpan(
            text: match[0],
            style: const TextStyle(
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (linkRegExp.hasMatch(match[0] ?? '')) {
                  await launchUrl(
                    Uri.parse(match[0]!),
                  );
                } else if (emailRegExp.hasMatch(match[0] ?? '')) {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: '${match[0]}',
                  );
                  await launchUrl(emailLaunchUri);
                } else if (phoneRegExp.hasMatch(match[0] ?? '')) {
                  final Uri phoneLaunchUri = Uri(
                    scheme: 'tel',
                    path: '${match[0]}',
                  );
                  await launchUrl(phoneLaunchUri);
                }
              },
          ),
        );
        return '';
      },
      onNonMatch: (String nonMatch) {
        // if text part is not matched with our pattern
        // this method is ommited and add new TextSpan to the list
        // to combine all text part with different style
        textSpans.add(TextSpan(text: nonMatch));
        return nonMatch;
      },
    );

    return textSpans;
  }
}

String textParser(String text) {
  return text.splitMapJoin(
    combinedRegExp,
    onMatch: (Match match) {
      String matchText = '${match[0]}';
      if (linkRegExp.hasMatch(match[0] ?? '')) {
        matchText = '<a href=${match[0]!}>${match[0]!}</a>';
      } else if (emailRegExp.hasMatch(match[0] ?? '')) {
        matchText = '<a href=mailto:${match[0]!}>${match[0]!}</a>';
      } else if (phoneRegExp.hasMatch(match[0] ?? '')) {
        matchText = '<a href=tel:${match[0]!}>${match[0]!}</a>';
      }
      return matchText;
    },
    onNonMatch: (String nonMatch) {
      return nonMatch;
    },
  );
}
