import 'package:flutter/material.dart';

abstract class DialogButton extends StatelessWidget {
  const DialogButton._({super.key});

  const factory DialogButton({
    required Widget child,
    required Color color,
    required void Function() onPressed,
  }) = _DialogButton;

  const factory DialogButton.text({
    Key? key,
    required Color color,
    required void Function() onPressed,
    required String text,
    TextStyle? style,
  }) = _TextDialogButton;

  const factory DialogButton.normal({
    Key? key,
    required void Function() onPressed,
    required String text,
  }) = _NormalDialogButton;

  const factory DialogButton.destructible({
    Key? key,
    required void Function() onPressed,
    required String text,
  }) = _DestructiveDialogButton;
}

class _DialogButton extends DialogButton {
  final Color color;
  final Widget child;
  final void Function() onPressed;
  const _DialogButton({
    required this.color,
    required this.child,
    required this.onPressed,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class _TextDialogButton extends DialogButton {
  final String text;
  final Color color;
  final TextStyle? style;
  final void Function() onPressed;
  const _TextDialogButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.style,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return DialogButton(
      color: color,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class _NormalDialogButton extends DialogButton {
  final String text;
  final void Function() onPressed;
  const _NormalDialogButton({
    super.key,
    required this.text,
    required this.onPressed,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return DialogButton.text(
      color: const Color(0xff495057),
      onPressed: onPressed,
      text: text,
      style: const TextStyle(color: Colors.white),
    );
  }
}

class _DestructiveDialogButton extends DialogButton {
  final String text;
  final void Function() onPressed;
  const _DestructiveDialogButton({
    super.key,
    required this.text,
    required this.onPressed,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return DialogButton.text(
      color: Theme.of(context).colorScheme.error,
      onPressed: onPressed,
      text: text,
      style: const TextStyle(color: Colors.white),
    );
  }
}
