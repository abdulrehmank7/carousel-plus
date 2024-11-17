# Carousel Plus page view flutter

![pub.dev](https://img.shields.io/badge/pub.dev-1.0.0-green)

<div align="left">
<img src="https://raw.githubusercontent.com/abdulrehmank7/carousel-plus/blob/main/carousel_plus/preview.png" width="30%" alt="" >
</div>

## Features

Create 3D style carousel with page view. The widget moves in Z-axis and rotates in X-axis. Giving it a 3D effect.

<div align="left">
<img src="https://raw.githubusercontent.com/abdulrehmank7/carousel-plus/blob/main/carousel_plus/preiview.gif" width="30%" >
</div>

## Getting started

add dependency to your `pubspec.yaml` file

```yaml

dependencies:
  carousel_page_view: ^1.0.0

```
import package in your dart file

```dart

import 'package:carousel_plus/carousel_plus.dart';

```
## Usage

Add `CarouselPlus` to your widget and pass the list of children that you want to display.

```dart

import 'package:carousal_test/generated/assets.dart';
import 'package:carousel_plus/carousel_plus.dart';
import 'package:flutter/material.dart';

const carouselImages = [
  Assets.sqImages1,
  Assets.sqImages2,
  Assets.sqImages3,
  Assets.sqImages4,
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: CarouselPlus(
            childSize: 100,
            onCenterItemPressed: (index) {
              print('Center item pressed: $index');
            },
            children: List.generate(carouselImages.length, (index) {
              return Image.asset(
                carouselImages[index],
                fit: BoxFit.cover,
              );
            }),
          ),
        ),
      ),
    );
  }
}

```


## Future roadmap
- Add more configuration option like rotation, scaling, etc.