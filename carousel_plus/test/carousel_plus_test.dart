import 'package:carousel_page_view/carousel_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds one to input values', () {
    final carousalPlus = CarouselPlus(
      children: [],
      onCenterItemPressed: (index) {},
    );
    expect(carousalPlus.children, []);
  });

  test('adds one to input values', () {
    final carousalPlus = CarouselPlus(
      children: [],
      onCenterItemPressed: (index) {},
    );
    expect(carousalPlus.onCenterItemPressed, (index) {});
  });

  test('adds one to input values', () {
    final carousalPlus = CarouselPlus(
      children: [],
      onCenterItemPressed: (index) {},
    );
    expect(carousalPlus.key, null);
  });
}
