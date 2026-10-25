import 'package:flutter/widgets.dart';

const double kPillHeight = 60;
const double kFabSize = 52;

/// Gap between the screen bottom and the floating tab pill.
double pillBottom(BuildContext context) =>
    12 + MediaQuery.viewPaddingOf(context).bottom;

/// Space a tab screen keeps free at the bottom so content clears the pill.
double navClearance(BuildContext context) =>
    pillBottom(context) + kPillHeight + 16;
