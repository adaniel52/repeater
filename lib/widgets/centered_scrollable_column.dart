import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';

class CenteredScrollableColumn extends StatefulWidget {
  final bool needPadding;
  final List<Widget> children;
  const CenteredScrollableColumn({
    super.key,
    this.needPadding = false,
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
            padding: !widget.needPadding
                ? Styles.noPadding
                : EdgeInsets.symmetric(
                    vertical: Styles.screenSpacing,
                    horizontal: (horizontalPadding < Styles.screenSpacing)
                        ? Styles.screenSpacing
                        : horizontalPadding,
                  ),
            child: Column(children: widget.children),
          ),
        ),
      ),
    );
  }
}
