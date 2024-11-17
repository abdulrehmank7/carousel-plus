import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class CarouselScrollEvents extends Equatable {
  const CarouselScrollEvents();

  @override
  List<Object> get props => [];
}

final class OnHorizontalDragStart extends CarouselScrollEvents {
  final DragStartDetails details;

  const OnHorizontalDragStart(this.details);

  @override
  List<Object> get props => [details];
}

final class OnHorizontalDragUpdate extends CarouselScrollEvents {
  final DragUpdateDetails details;

  const OnHorizontalDragUpdate(this.details);

  @override
  List<Object> get props => [details];
}

final class OnHorizontalDragEnd extends CarouselScrollEvents {
  const OnHorizontalDragEnd();
}
