import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      title: 'Home page',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    ),
  ));
}

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(seconds: 1),
    ((i) => i + 1),
  ),
);

const names = [
  "manaye",
  'tringo',
  "shiferaw",
  'jo',
  'eden',
  'tedi',
];

final nameProvider = StreamProvider(((ref) =>
    ref.watch(tickerProvider.stream).map((count) => names.getRange(0, count))));

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final names = ref.watch(nameProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('HomePage')),
        body: Column(children: [
          names.when(
              data: ((data) => Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(data.elementAt(index)),
                        );
                      })))),
              error: ((error, stackTrace) => const Text("reach at the end")),
              loading: (() => const CircularProgressIndicator()))
        ]));
  }
}
