import 'dart:async';

import 'package:flutter/material.dart';

enum AsyncButtonState { init, submitting, completed, error }

// https://flutterdart.dk/flutter-data-from-child-to-parent/

typedef AsyncCall = Future<bool> Function();

class AsyncButton extends StatefulWidget {
  const AsyncButton({
    Key? key,
    required this.onAsyncCall,
    required this.initButtonChild,
  }) : super(key: key);

  final AsyncCall onAsyncCall;
  final Widget initButtonChild;

  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  AsyncButtonState state = AsyncButtonState.init;
  bool _isAnimating = true;

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;
    final isInit = _isAnimating || state == AsyncButtonState.init;
    final isDone = state == AsyncButtonState.completed;
    final isError = state == AsyncButtonState.error;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      onEnd: () => setState(() {
        _isAnimating = !_isAnimating;
      }),
      width: state == AsyncButtonState.init ? buttonWidth : 70,
      height: 60,
      child: isInit ? initButton() : circularContainer(isDone, isError),
    );
  }

  Widget circularContainer(bool done, bool error) {
    final color = done ? Colors.green : Colors.blue;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: containerState(done, error),
      ),
    );
  }

  Widget containerState(bool done, bool error) {
    if (done) {
      return const Icon(Icons.done, size: 50, color: Colors.white);
    }

    if (error) {
      return const Icon(Icons.error, size: 50, color: Colors.white);
    }

    return const CircularProgressIndicator(color: Colors.white);
  }

  Widget initButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        onPressed: () async {
          updateState(AsyncButtonState.submitting);
          await widget.onAsyncCall().then(
            (value) {
              if (value) {
                updateState(AsyncButtonState.completed);
              } else {
                updateState(AsyncButtonState.error);
              }
              Timer(const Duration(seconds: 1), () {
                updateState(AsyncButtonState.init);
              });
            },
          );
        },
        child: widget.initButtonChild,
      ),
    );
  }

  void updateState(AsyncButtonState state) {
    setState(() {
      this.state = state;
    });
  }
}
