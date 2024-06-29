import 'package:flutter/material.dart';

class TestGotten extends StatefulWidget {
  const TestGotten({super.key});

  @override
  State<TestGotten> createState() => _TestGottenState();
}

class _TestGottenState extends State<TestGotten> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.75,
                  color: Colors.red,
                ),
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.blue,
                    ),
                    const Positioned(right: 0, child: Text("data"))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
