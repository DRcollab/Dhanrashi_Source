import 'dart:ui';

import 'package:flutter/material.dart';

class VanishKeyBoard extends StatelessWidget {

  Widget child;
  Function() onTap;
  VanishKeyBoard({required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: this.child,
      onTap: (){
        this.onTap();
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }

      },
    );
  }
}
