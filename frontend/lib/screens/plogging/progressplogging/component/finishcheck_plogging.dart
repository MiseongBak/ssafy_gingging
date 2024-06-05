import 'package:flutter/material.dart';

class FinishCheckPloggingDialog extends StatefulWidget {
  final Function onConfirm;

  const FinishCheckPloggingDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  State<FinishCheckPloggingDialog> createState() =>
      _FinishCheckPloggingDialogState();
}

class _FinishCheckPloggingDialogState extends State<FinishCheckPloggingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '원정을 종료하시겠습니까?',
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('취소')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onConfirm();
                  },
                  child: const Text('확인'))
            ],
          ),
        ],
      ),
    );
  }
}
