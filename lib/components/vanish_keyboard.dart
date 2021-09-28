import 'dart:ui';

import 'package:flutter/material.dart';

class VanishKeyBoard extends StatelessWidget {

  Widget child;
  VanishKeyBoard({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: this.child,
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }

      },
    );
  }
}
