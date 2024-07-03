import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestGotten extends StatefulWidget {
  const TestGotten({super.key});

  @override
  State<TestGotten> createState() => _TestGottenState();
}

class _TestGottenState extends State<TestGotten> {
  @override
  Widget build(BuildContext context) {
    print("object");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<Counter>().increment();
              },
              child: const Text("data"),
            ),
            Consumer<Counter>(
              builder: (context, counter, child) {
                return Column(
                  children: [
                    Text(counter.count.toString()), // Bu kısım yeniden oluşturulur.
                    child!, // Bu kısım yeniden oluşturulmaz, aynı referans korunur.
                  ],
                );
              },
              child:
                  const Text('This is a static child'), // Bu widget, builder dışında tanımlandığı için yeniden oluşturulmaz.
            ),
            // Text(Provider.of<int>(context).toString())
          ],
        ),
      ),
    );
  }
}

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterStream {
  Stream<int> get stream async* {
    int counter = 0;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield counter++;
    }
  }
}
