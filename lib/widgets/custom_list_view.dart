import 'package:flutter/material.dart';
import 'package:repeater/utils/constants/styles.dart';

class CustomListView extends StatefulWidget {
  final double? width;
  final List<Widget> children;
  const CustomListView({
    super.key,
    required this.children,
    this.width, // = Styles.largeBreakpoint,
  });

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (widget.width == null)
        ? Styles.screenSpacing
        : (width - widget.width!) / 2;

    return Scrollbar(
      controller: _scrollController,
      child: ListView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(
          vertical: Styles.screenSpacing,
          horizontal: (horizontalPadding < Styles.screenSpacing)
              ? Styles.screenSpacing
              : horizontalPadding,
        ),
        children: widget.children,
      ),
    );
  }
}