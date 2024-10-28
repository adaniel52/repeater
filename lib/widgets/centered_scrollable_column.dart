import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';

class CenteredScrollableColumn extends StatefulWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;
  const CenteredScrollableColumn({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
  });

  @override
  State<CenteredScrollableColumn> createState() =>
      _CenteredScrollableColumnState();
}

class _CenteredScrollableColumnState extends State<CenteredScrollableColumn> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width - Styles.smallBreakpoint) / 2;

    return Center(
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Styles.screenSpacing,
              horizontal: (horizontalPadding < Styles.screenSpacing)
                  ? Styles.screenSpacing
                  : horizontalPadding,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: widget.crossAxisAlignment,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}
