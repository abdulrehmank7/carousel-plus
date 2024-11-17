import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/carousel_scroll_events.dart';
import '../bloc/carousel_scroll_state.dart';

class CarouselBloc extends Bloc<CarouselScrollEvents, CarouselScrollState> {
  CarouselBloc(
    double page,
    double startPosition,
    double currentPosition,
    double childSize,
    double scrollSpeedMultiplier,
    int listSize,
    int lengthMultiplier,
  ) : super(
          CarouselScrollState(
            page: page,
            startPosition: startPosition,
            currentPosition: currentPosition,
            childSize: childSize,
            scrollSpeedMultiplier: scrollSpeedMultiplier,
            listSize: listSize,
            lengthMultiplier: lengthMultiplier,
          ),
        ) {
    on<OnHorizontalDragStart>(_onHorizontalDragStart);
    on<OnHorizontalDragUpdate>(_onHorizontalDragUpdate);
    on<OnHorizontalDragEnd>(_onHorizontalDragEnd);
  }

  void _onHorizontalDragStart(
    OnHorizontalDragStart event,
    Emitter<CarouselScrollState> emit,
  ) {
    emit(state.copyWith(
      startPosition: (state.page * state.childSize) - event.details.globalPosition.dx * state.scrollSpeedMultiplier,
    ));
  }

  void _onHorizontalDragUpdate(
    OnHorizontalDragUpdate event,
    Emitter<CarouselScrollState> emit,
  ) {
    double distance = state.startPosition + event.details.globalPosition.dx * state.scrollSpeedMultiplier;

    emit(state.copyWith(
      currentPosition: distance,
      page: ((state.currentPosition / state.childSize).clamp(0, state.increasedImageLength - 1)),
    ));
  }

  void _onHorizontalDragEnd(
    OnHorizontalDragEnd event,
    Emitter<CarouselScrollState> emit,
  ) {
    emit(state.copyWith(
      page: state.page.roundToDouble(),
    ));
  }
}
