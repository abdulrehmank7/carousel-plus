import 'package:equatable/equatable.dart';

class CarouselScrollState extends Equatable {
  final double page;
  final double startPosition;
  final double currentPosition;
  final double childSize;
  final double scrollSpeedMultiplier;
  final int listSize;
  final int lengthMultiplier;

  const CarouselScrollState({
    required this.page,
    required this.startPosition,
    required this.currentPosition,
    required this.childSize,
    required this.scrollSpeedMultiplier,
    required this.listSize,
    required this.lengthMultiplier,
  });

  CarouselScrollState copyWith({
    double? page,
    double? startPosition,
    double? currentPosition,
    double? childSize,
    double? scrollSpeedMultiplier,
    int? listSize,
    int? lengthMultiplier,
  }) {
    return CarouselScrollState(
      page: page ?? this.page,
      startPosition: startPosition ?? this.startPosition,
      currentPosition: currentPosition ?? this.currentPosition,
      childSize: childSize ?? this.childSize,
      scrollSpeedMultiplier: scrollSpeedMultiplier ?? this.scrollSpeedMultiplier,
      listSize: listSize ?? this.listSize,
      lengthMultiplier: lengthMultiplier ?? this.lengthMultiplier,
    );
  }

  int get increasedImageLength => listSize * lengthMultiplier;

  int get currentCenterIndex {
    if (page.toInt() % listSize == 0) return 0;
    return listSize - (page.toInt() % listSize);
  }

  int get centerIndex => increasedImageLength ~/ 2;

  @override
  List<Object> get props => [
        page,
        startPosition,
        currentPosition,
        childSize,
        scrollSpeedMultiplier,
        listSize,
        lengthMultiplier,
      ];
}
