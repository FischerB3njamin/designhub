import 'package:designhub/features/question/models/roll_out_type.dart';
import 'package:flutter/material.dart';

class BtnSgRolloutType extends StatelessWidget {
  final Function callback;
  final RollOutType rollOutType;

  const BtnSgRolloutType({
    super.key,
    required this.callback,
    required this.rollOutType,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      showSelectedIcon: false,
      onSelectionChanged: (newSelection) => callback(newSelection),
      emptySelectionAllowed: true,
      selected: {rollOutType},
      segments: [
        ButtonSegment(
          value: RollOutType.like,
          label: Text("like"),
        ),
        ButtonSegment(
          value: RollOutType.dislike,
          label: Text("dislike"),
        ),
        ButtonSegment(
          value: RollOutType.both,
          label: Text("both"),
        ),
      ],
    );
  }
}
