import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'dart:math';

class IncenseModel extends SpriteComponent with DragCallbacks, HasGameRef {
  final double SCREEN_WIDTH;
  final double SCREEN_HEIGHT;

  late double width, height;

  bool status_fire = false;
  bool status_rotate = false;

  double? x1, y1;
  double? x2, y2;

  SpriteAnimationComponent fireAnimation = SpriteAnimationComponent();

  IncenseModel(this.SCREEN_WIDTH, this.SCREEN_HEIGHT) {
    this.width = SCREEN_WIDTH / 19;
    this.height = SCREEN_HEIGHT / 7;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    this
      ..sprite = await gameRef.loadSprite('caynhan.png')
      ..size = Vector2(width, height)
      // set position in the center of the screen
      ..x = SCREEN_WIDTH / 2
      ..y = SCREEN_HEIGHT / 2;
  }

  double rotateX(double x, double y, double angle) {
    return x * cos(angle) - y * sin(angle);
  }

  double rotateY(double x, double y, double angle) {
    return x * sin(angle) + y * cos(angle);
  }

  @override
  void update(double dt) {
    super.update(dt);

    double centerX = x + width / 2;
    double centerY = y + height / 2;

    // Tính toán x1, y1 theo angle
    x1 = rotateX(centerX - width / 2, centerY - height / 2, angle);
    y1 = rotateY(centerX - width / 2, centerY - height / 2, angle);

    if (status_rotate) {
      if (angle > -20 * dt) angle -= 2 * dt;
    } else {
      if (angle <= 0) angle += 2 * dt;
    }

    print("location X: $x");
    print("location Y: $y");

    print("location X1: $x1");
    print("location Y1: $y1");
  }

  @override
  void onDragStart(DragStartEvent event) {
    print("click in");
    status_rotate = true;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    print("click out");
    status_rotate = false;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    x += event.localDelta.x;
    y += event.localDelta.y;

    if (x < 0) x = 0;
    if (y < 0) y = 0;
    if (x + width > SCREEN_WIDTH) x = SCREEN_WIDTH - width;
    if (y + height > SCREEN_HEIGHT) y = SCREEN_HEIGHT - height;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderDebug(canvas);
  }

  @override
  void renderDebug(Canvas canvas) {
    Rect hitbox = Rect.fromLTWH(0, 0, width, height);

    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRect(hitbox, paint);
  }
}
