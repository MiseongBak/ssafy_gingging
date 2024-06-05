import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/core/theme/constant/app_colors.dart';
import 'package:frontend/core/theme/custom/custom_font_style.dart';

class ExpBar extends StatefulWidget {
  final int exp;

  const ExpBar({
    super.key,
    required this.exp,
  });

  @override
  State<ExpBar> createState() => _ExpBarState();
}

class _ExpBarState extends State<ExpBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3, color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: AppColors.basicgray.withOpacity(0.5),
                offset: Offset(0, 4),
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.013,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.025,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.013,
          left: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.025,
            width: widget.exp / 1000 * 100 == 0
                ? MediaQuery.of(context).size.width * 0
                : widget.exp / 1000 * 100 < 10
                    ? MediaQuery.of(context).size.width * 0.04
                    : widget.exp / 1000 * 100 < 20
                        ? MediaQuery.of(context).size.width * 0.08
                        : widget.exp / 1000 * 100 < 30
                            ? MediaQuery.of(context).size.width * 0.12
                            : widget.exp / 1000 * 100 < 40
                                ? MediaQuery.of(context).size.width * 0.16
                                : widget.exp / 1000 * 100 < 50
                                    ? MediaQuery.of(context).size.width * 0.2
                                    : widget.exp / 1000 * 100 < 60
                                        ? MediaQuery.of(context).size.width *
                                            0.24
                                        : widget.exp / 1000 * 100 < 70
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.28
                                            : widget.exp / 1000 * 100 < 80
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.32
                                                : widget.exp / 1000 * 100 < 90
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.36
                                                    : widget.exp / 1000 * 100 <
                                                            100
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.38
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.01,
          right: MediaQuery.of(context).size.width * 0.025,
          child: Container(
            child: Text(
              '${widget.exp / 1000 * 100}%',
              style: CustomFontStyle.getTextStyle(
                  context, CustomFontStyle.yeonSung60),
            ),
          ),
        )
      ],
    );
  }
}
