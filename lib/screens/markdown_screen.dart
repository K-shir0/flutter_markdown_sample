import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class MarkdownScreen extends StatelessWidget {
  const MarkdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Markdown(
        selectable: true,
        builders: {
          'h1': CustomHeader1Builder(),
          'pre': CustomPreBuilder(),
          'blockquote': CustomBlockQuoteBuilder(),
        },
        imageBuilder: (uri, _, __) {
          return Center(
            child: Image.network(
              uri.toString(),
            ),
          );
        },
        onTapLink: (text, href, title) {
          if (href != null) {
            launch(href);
          }
        },
        data: '''
# h1 見出し
## h2 見出し
### h3 見出し
#### h4 見出し
##### h5 見出し
###### h6 見出し

# 水平
---

# 文字
 
**太字**

__太字__

*斜体のテキスト*

_斜体のテキスト_

~~取り消し線~~

# ブロッククォート

> ブロッククォート
>> ブロッククォート
>>>ブロッククォート

# リスト

- リスト
- リスト
  - リスト

1. リスト
2. リスト
3. リスト
  1. リスト
  2. リスト
  
# コード

インライン `code`

``` dart
print("Hello World");
```

# イメージ

![](https://picsum.photos/200/300)

# リンク

[Zenn](https://zenn.dev/k_shir0)

      ''',
      ),
    );
  }
}

/// H1
class CustomHeader1Builder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return H1(text: text.text);
  }
}

/// BlockQuote
class CustomBlockQuoteBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    return BlockQuote(text: element.textContent);
  }

  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return BlockQuote(text: text.text);
  }
}

/// Pre
class CustomPreBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    return Pre(text: text.text);
  }
}

class H1 extends StatelessWidget {
  final String text;

  const H1({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}

class BlockQuote extends StatelessWidget {
  final String text;

  const BlockQuote({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 4,
                color: Theme.of(context).dividerColor,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  child: SelectableText(
                    text,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.caption?.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class Pre extends StatelessWidget {
  final String text;

  const Pre({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                child: SelectableText(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                final data = ClipboardData(text: text);
                Clipboard.setData(data);
              },
              tooltip: 'クリップボードにコピー',
              icon: const Icon(
                Icons.content_copy_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}
