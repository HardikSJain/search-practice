import 'package:flutter/material.dart';

class CustomSliverAppBar extends SliverAppBar {
  CustomSliverAppBar.widgetWrapper({
    super.key,
    required Widget child,
    required BuildContext context,
  }) : super(
          toolbarHeight: 150,
          leading: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: child),
            ],
          ),
          titleSpacing: 0,
          leadingWidth: MediaQuery.of(context).size.width,
          elevation: 0,
          backgroundColor: Colors.transparent,
          floating: true,
        );
}
