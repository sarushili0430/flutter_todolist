import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/view_model/view_models.dart';
import 'package:go_router/go_router.dart';

class TodoAddPage extends ConsumerWidget {
  const TodoAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(todoNotifierProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text("New ToDo"),
          leading: IconButton(
              onPressed: () {
                context.go("/");
              },
              icon: Icon(Icons.close)),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextInput(),
          ],
        ));
  }
}

class TextInput extends ConsumerWidget {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  TextInput({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            const SizedBox(height: 8),
            TextField(
                controller: _titleTextController,
                decoration: InputDecoration(
                  hintText: "Title",
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                )),
            const SizedBox(height: 16),
            TextField(
                controller: _descriptionTextController,
                decoration: InputDecoration(
                  hintText: "",
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                )),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              onPressed: () {
                ref
                    .read(todoNotifierProvider.notifier)
                    .addTodo(_titleTextController.text);
                context.go("/");
              },
              child: Text('リスト追加'),
            ),
          ],
        ));
  }
}
