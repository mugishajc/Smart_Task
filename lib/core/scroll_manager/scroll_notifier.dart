import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import 'scroll_state.dart';

class ScrollNotifier extends StateNotifier<ScrollState> {
  final Ref ref;
  final ScrollController scrollController;
  final BuildContext context; // Add context parameter

  ScrollNotifier({required this.ref, required this.scrollController, required this.context}) : super(ScrollInitialState()) {
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  get scrollNotifierState => state;

  void scrollListener() {
    double maxScrollExtent = scrollController.position.maxScrollExtent;
    double currentScrollPosition = scrollController.position.pixels;
    double amountOfSpaceFromTheBottom = MediaQuery.of(context).size.width * 0.20;

    if (state is! ScrollReachedBottomState && maxScrollExtent - currentScrollPosition <= amountOfSpaceFromTheBottom) {
      if (state is! ScrollPauseState) {
        state = ScrollReachedBottomState();
      }
    }
  }

  void decideScrollState(bool shouldPaginate) {
    if (shouldPaginate) {
      resetState();
    } else {
      pauseState();
    }
  }

  void resetState() {
    state = ScrollInitialState();
  }

  void pauseState() {
    toast("You have reached the end of the list, Murakoze !!");
    state = ScrollPauseState();
  }
}