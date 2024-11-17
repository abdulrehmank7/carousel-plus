import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/carousel_bloc.dart';
import '../bloc/carousel_scroll_events.dart';
import '../bloc/carousel_scroll_state.dart';

class CarouselPlus extends StatelessWidget {
  final List<Widget> children;
  final Function(int index) onCenterItemPressed;
  final double childSize;
  final _lengthMultiplier = 10;
  final _scrollSpeedMultiplier = 1.5;

  const CarouselPlus({
    required this.children,
    required this.onCenterItemPressed,
    this.childSize = 100.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) {
        final centerIndex = (children.length * _lengthMultiplier) ~/ 2;
        return CarouselBloc(
          centerIndex.toDouble(),
          (centerIndex * childSize),
          0,
          childSize,
          _scrollSpeedMultiplier,
          children.length,
          _lengthMultiplier,
        );
      },
      child: _CarouselPlusWidget(
        onCenterItemPressed: onCenterItemPressed,
        children: children,
      ),
    );
  }
}

class _CarouselPlusWidget extends StatelessWidget {
  final List<Widget> children;
  final Function(int index) onCenterItemPressed;

  const _CarouselPlusWidget({
    required this.children,
    required this.onCenterItemPressed,
  });

  final _opacityMultiplier = 2;

  List<({Widget child, int index})> get childrenWithIndex {
    return List.generate(
      children.length,
      (index) => (child: children[index], index: index),
    );
  }

  List<Widget> getStackChildInOrder(CarouselScrollState state) {
    final List<Widget> stackChildren = List.generate(
      state.increasedImageLength,
      (stackIndex) {
        final data = childrenWithIndex[stackIndex % childrenWithIndex.length];
        final index = stackIndex;
        bool isOnLeft = index < state.page;
        final diff = (index - state.page).abs();
        final sf = (1 - (diff * 0.3)).clamp(0.0, 1.0);
        final scale = sf * 1.2;

        // Base multiplier for the first card
        double baseMultiplier = 90.0;
        // Decrease by 20 for each subsequent card
        double diminishingFactor = 20.0;
        // Limit the diminishing effect to 5 steps
        double maxSteps = 5.0;

        // Calculate the translation based on the card's distance from the center
        double step = diff <= maxSteps ? baseMultiplier - diminishingFactor * (diff - 1) : 0;
        double translation = step * diff;

        // Calculate opacity based on distance from the center
        double opacity = (1.0 - diff / (childrenWithIndex.length / 2) * _opacityMultiplier).clamp(0.0, 1.0);

        return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.003)
            ..translate(
              (isOnLeft ? translation : -translation),
              0.0,
              sf * -state.childSize,
            )
            ..scale(scale.clamp(0, 1.1), scale.clamp(0, 1.1))
            ..rotateY(diff.clamp(0, 1) * 0.8 * (isOnLeft ? 1 : -1)),
          child: Stack(
            children: [
              Container(
                width: state.childSize,
                height: state.childSize,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: data.child,
              ),
              Container(
                width: state.childSize,
                height: state.childSize,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(1 - opacity),
                ),
              ),
            ],
          ),
        );
      },
    );
    for (int index = state.increasedImageLength - 1; index >= state.page.round().clamp(0, state.increasedImageLength - 1); index--) {
      stackChildren.insert(
        state.increasedImageLength - 1,
        stackChildren.removeAt(index),
      );
    }

    return stackChildren;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (details) {
        context.read<CarouselBloc>().add(OnHorizontalDragStart(details));
      },
      onHorizontalDragUpdate: (details) {
        context.read<CarouselBloc>().add(OnHorizontalDragUpdate(details));
      },
      onHorizontalDragEnd: (details) {
        context.read<CarouselBloc>().add(const OnHorizontalDragEnd());
      },
      onTap: () {
        onCenterItemPressed(context.read<CarouselBloc>().state.currentCenterIndex);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: BlocBuilder(
            bloc: context.read<CarouselBloc>(),
            builder: (BuildContext context, CarouselScrollState state) {
              return Stack(
                children: getStackChildInOrder(state),
              );
            },
          ),
        ),
      ),
    );
  }
}
