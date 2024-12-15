import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/view_model/view_models.dart';

class TodoAddPage extends ConsumerWidget {
  const TodoAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextInput(),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop("");
            },
            child: Text("キャンセル"))
      ],
    )));
  }
}

class TextInput extends ConsumerWidget {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            TextFormField(
              controller: _textController,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              onPressed: () {
                ref
                    .read(todoNotifierProvider.notifier)
                    .addTodo(_textController.text);
                Navigator.of(context).pop();
              },
              child: Text('リスト追加'),
            ),
          ],
        ));
  }
}
